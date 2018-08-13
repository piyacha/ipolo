ActiveAdmin.register Quotation do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

# requires :first_name, type: String, desc: ""
# requires :address, type: String, desc: ""
# requires :tel, type: String, desc: ""
# requires :email, type: String, desc: ""
# requires :note, type: String, desc: ""
#
# requires :stuff_img, type: String, desc: ""
#
# requires :estimate_cost, type: String, desc: ""
# requires :stuff_picker, type: String, desc: ""
# requires :stuff_price, type: String, desc: ""
# requires :base_price, type: String, desc: ""
#
# optional :company_name, type: String, desc: ""
# optional :company_branch, type: String, desc: ""
# optional :tax_identification_number, type: String, desc: ""

  menu parent: 'Order',  priority: 2

  filter :first_name
  filter :created_at
  filter :updated_at

  permit_params :status, :first_name, :address, :tel ,:email ,:stuff_img ,:note ,:estimate_cost ,:stuff_picker , :fax,
                :base_price ,:company_name ,:company_branch ,:tax_identification_number,:option_price_details,:price_amount_report,:admin_user_id,:complete,:total_price,
                :final_price,:credit_id,:pledge_id,:current_credit,:current_pledge,
                quotation_prices_attributes: [:id, :name, :amount, :price, :_destroy]

  action_item :print, only: [:show] do
    # @stuff_quotation = stuff_quotation
    link_to "Print", print_order_path(:id => params[:id],:from => "quotation"), :target => "_blank"
  end

  action_item :view, only: [:edit] do
    link_to "แสดงรายละเอียด", "/admin/quotations/#{params[:id]}"
  end

  controller do

    def calculateFinalPrice

      if @quotation.credit.nil?
        credit = Credit.order("priority DESC").first
        @quotation.credit = credit
        @quotation.current_credit = credit.value
      else
        credit = @quotation.credit
        @quotation.current_credit = credit.value
      end

      if @quotation.pledge.nil?
        pledge = Pledge.order("priority DESC").first
        @quotation.pledge = pledge
        @quotation.current_pledge = pledge.value
      else
        pledge = @quotation.pledge
        @quotation.current_pledge = pledge.value
      end

      @quotation.final_price = (@quotation.total_price * credit.value * pledge.value).round(1)
      @quotation.save
    end

    def createparams
      super()
      calculateFinalPrice
    end

    def update
      super()
      calculateFinalPrice
    end

  end

  member_action :email, method: :get do
    @quotation = Quotation.quotation_report(params[:id])
    render 'preview_email'
  end

  scope "All",  :default => true do |quotation|
    if current_admin_user.anonymous == true
      Quotation.all().order('updated_at DESC')
    else
      Quotation.where({admin_user:current_admin_user}).order('updated_at DESC')
    end
  end


  index do
    div do stylesheet_link_tag "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" end
    div do javascript_include_tag "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" end

    div class:'modal fade',id:'quotaion_loading_email',tabindex:'-1',role:'dialog' do
      div class:'modal-dialog modal-sm',role:'document' do
        div class:'modal-content' do
          div class:'modal-body',align:'center' do
            image_tag("print/email_loading.gif", width: '200px',height:'200px')
          end
        end
      end
    end

    selectable_column
    column :id
    column :admin_user
    column :first_name
    column :tel
    column :fax
    column :email
    column "Confirm" do |quotation|
      if quotation.complete
        button type:'button',id:'',class:'btn btn-success',value:quotation.id  do
          span class:'glyphicon glyphicon-ok',style:'margin-right:5px' do

          end
          span do
            'Sent'
          end
        end
      else
        button type:'button',id:'',class:'btn btn-warning quotation-confirm',value:quotation.id  do
          span class:'glyphicon glyphicon-remove',style:'margin-right:5px' do

          end
          span do
            'Not Sent'
          end
        end
      end
    end

    column "View" do |quotation|
      a href:"/admin/quotations/#{quotation.id}" do
        button type:'button',id:'',class:'btn btn-default',value:quotation.id  do
          span class:'glyphicon glyphicon-search',style:'margin-right:5px' do

          end
          span do
            'View'
          end
        end
      end
    end
    column "Edit" do |quotation|
      a href:"/admin/quotations/#{quotation.id}/edit" do
        button type:'button',id:'',class:'btn btn-default',value:quotation.id  do
          span class:'glyphicon glyphicon-cog',style:'margin-right:5px' do

          end
          span do
            'Edit'
          end
        end
      end
    end
    column "Delete" do |quotation|
      # a href:"/admin/quotations/#{quotation.id}" do
      #   button type:'button',id:'',class:'btn btn-danger',value:quotation.id  do
      #     'Delete'
      #   end
      # end
      link_to "Delete", admin_quotation_path(quotation), :method => :delete, :data => {:confirm => "ยืนยันการลบ ?"},:class => 'btn btn-danger',:style => 'color:white;'
    end
    actions defaults: false do |quotation|
      # link_to 'Send Email', email_admin_quotation_path(quotation)

      a href:email_admin_quotation_path(quotation) do
        # quotation_send_email
        button type:'button',id:'',class:'btn btn-primary',value:quotation.id  do
          span class:'glyphicon glyphicon-envelope',style:'margin-right:5px' do

          end
          span do
            'View Email'
          end
        end
      end

    end

  end
  sidebar "ข้อมูลทั่วไป", only: :show,class:"quotation_sidebar" do
    attributes_table do

      row "ส่งอีเมล์" do |c|
        button type:'button',id:'',class:'btn btn-primary quotation_send_email',value:quotation.id  do
          span class:'glyphicon glyphicon-envelope',style:'margin-right:5px' do

          end
          span do
            'Email'
          end
        end
      end

      row "รับผิดชอบโดย" do |c|
        c.admin_user
      end

      row "เครดิต" do |c|
        c.credit
      end
      row "เครดิต ที่ใช้คำนวน " do |c|
        c.current_credit
      end

      row "มัดจำ" do |c|
        c.pledge
      end
      row "มัดจำ ที่ใช้คำนวน" do |c|
        c.current_pledge
      end
      # row "ราคารวม (ทุน x กำไร)" do |c|
      #   c.total_price
      # end
      row "ราคาสุดท้าย" do |c|
        c.final_price
      end
    end
  end
  sidebar "ข้อมูลผู้เสนอราคา", only: :show,class:"quotation_sidebar" do

    attributes_table do
      row "ชื่อ" do |c|
        c.first_name
      end
      row "ติดต่อ" do |c|
        c.tel
      end
      row "แฟกซ์" do |c|
        c.fax
      end
      row "อีเมล" do |c|
        c.email
      end
      row "ที่อยู่" do |c|
        c.address
      end
      row "ชื่อ บริษัท" do |c|
        c.company_name
      end
      row "สาขา บริษัท" do |c|
        c.company_branch
      end
      row "หมายเลข ผู้เสียภาษี" do |c|
        c.tax_identification_number
      end
      # row "ราคา พื่นฐาน" do
      #   c.base_price
      # end
      # ==============================
    end

  end

  sidebar "โลโก้", only: :show,class:"order_sidebar" do
    order = Quotation.find(params[:id])
    if order.stuff_picker
      stuff_picker = JSON.parse(order.stuff_picker)
      first_name = order.first_name
      all_stuff_logo = Stuff.where(stuff_type:StuffType.where({name:'LOGO'}).first);
      all_stuff_logo.each do |logo|
        columns do
          stuff_picker.each do |picker|
            if picker["stuff_type_name"]=="LOGO"
              if picker[logo.name]
                table do
                  tr do
                    th do
                      logo.desc
                    end
                  end
                  td class:"td_logo" do
                    if picker[logo.name]
                      image_tag(picker[logo.name]['img_path'], width: '100%')
                    else
                      "ไม่พบโลโก้"
                    end
                  end
                end
              end
            else
              div style:'display:none;' do
                "ไม่พบโลโก้"
              end
            end
          end
          column width: "100%" do
            # column max_width: "100%", min_width: "400px" do
            table do
              stuff_picker.each do |picker|
                if picker["stuff_type_name"]=="LOGO"
                  if picker[logo.name]
                    tr do
                      th do
                        "กว้าง(cm)"
                      end
                      th do
                        "สูง(cm)"
                      end
                      th do
                        "สี"
                      end
                      th do
                        "ประเภท"
                      end
                      th do
                        "โหลด"
                      end
                    end
                  end
                else
                  div style:'display:none;' do
                    "ไม่พบโลโก้"
                  end
                end
              end
              stuff_picker.each do |picker|
                if picker["stuff_type_name"]=="LOGO"
                  if picker[logo.name]
                    if picker[logo.name]['img_id']
                      tmp_logo = StuffLogo.find(picker[logo.name]['img_id'])
                      if tmp_logo
                        tr do
                          td class:"td_logo" do
                            tmp_logo.logo_width
                          end
                          td class:"td_logo" do
                            tmp_logo.logo_height
                          end
                          td class:"td_logo" do
                            tmp_logo.color_number
                          end
                          td class:"td_logo" do
                            tmp_logo.logo_type
                          end
                          td class:"td_logo" do
                            if picker['logo_front_l']
                              a target:"_blank",href:picker[logo.name]['img_path'],download:first_name+"-"+logo.name do
                                button type:'button',class:'btn btn-default' do
                                  'โหลด'
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                else
                  div style:'display:none;' do
                    "ไม่พบโลโก้"
                  end
                end
              end
            end
          end
        end

      end

    end #  end if order.stuff_picker

  end




  show do |c|

    attributes_table do
      row "รูป สิ้นค้า" do |quotation|
        div class:"quotation_center" do
          if quotation.stuff_img
            image_tag(quotation.stuff_img.url(:medium))
          end
        end
      end
    end

    attributes_table do

      if c.stuff_picker
        columns do
          column width: "100%" do
            # column max_width: "100%", min_width: "400px" do
            table do
              tr do
                th do
                  "รูปแบบประเภท"
                end
                th do
                  "ชื่อประเภท"
                end
                th do
                  "รูป ผิวสัมผัส"
                end
                th do
                  "ชื่อ ผิวสัมผัส"
                end
                # th do
                #   "ราคา(ผิวสัมผ้ส) %"
                # end
              end
              stuff_picker = JSON.parse(c.stuff_picker)
              stuff_picker.each do |picker|
                stuff = Stuff.find(picker["stuff_id"])

                if picker["stuff_type_name"]=="TYPE"
                  tr do
                    td do
                      if stuff.stuff_product_img
                        image_tag(stuff.stuff_product_img.url(:thumb))
                      end
                    end
                    td do
                      stuff.name
                    end
                    td do
                      image_tag(picker["texture_img"])
                    end
                    td do
                      picker["texture_name"]
                    end
                    # td do
                    #   picker["texture_price"]
                    # end
                  end
                end
              end
            end
          end
        end

        columns do
          column width: "100%" do
            stuff_picker = JSON.parse(c.stuff_picker)
            table do
              tr do
                th do
                  "ชื่อ ชิ้นส่วน"
                end
                # th do
                #   "รูปพรีวิว 1"
                # end
                # th doกฟดเ
                #   "รูปพรีวิว 2"
                # end
                th do
                  "ชื่อสีที่ 1"
                end
                th do
                  "สีส่วนที่ 1"
                end
                th do
                  "ชื่อสีที่ 2"
                end
                th do
                  "สีส่วนที่ 2"
                end
                # th do
                #   "ราคา %"
                # end
              end
              stuff_picker.each do |picker|
                stuff = Stuff.find(picker["stuff_id"])

                if picker["stuff_type_name"]!="TYPE" && picker["stuff_type_name"]!="LOGO"
                  tr do
                    td do
                      stuff.name
                    end
                    # td do
                    #   if stuff.stuff_product_img
                    #     image_tag(stuff.stuff_product_img.url(:thumb))
                    #   end
                    # end
                    # td do
                    #   if stuff.stuff_product_img_two
                    #     image_tag(stuff.stuff_product_img_two.url(:thumb))
                    #   end
                    # end
                    td do
                      if picker["color_code_0_name"]
                        picker["color_code_0_name"]
                      else
                        "ไม่พบชื่อ"
                      end
                    end
                    td do
                      if picker["color_code_0"]
                        div style:'background-color:'+picker["color_code_0"]+';width:100px;height:50px;' do
                        end
                      else
                        "ไม่พบสี"
                      end
                    end

                    td do
                      if picker["color_code_0_name"]
                        picker["color_code_0_name"]
                      else
                        "ไม่พบชื่อ"
                      end
                    end
                    td do
                      if picker["color_code_1"]
                        div style:'background-color:'+picker["color_code_1"]+';width:100px;height:50px;' do
                        end
                      else
                        "ไม่พบสี"
                      end
                    end
                    # td do
                    #   picker["price"]
                    # end
                  end
                else
                end
              end
            end
          end
        end

      end # if stuff picker

      row "เพิ่มเติมพิเศษ" do
        c.option_price_details
      end

      # row "ราคา ต่อชิ้น และ จำนวนที่สั้ง" do
      #   estimate = JSON.parse(c.estimate_cost)
      #   table do
      #     tr do
      #       th do
      #         "ขนาด"
      #       end
      #       th do
      #         "จำนวน"
      #       end
      #       th do
      #         "ราคาประมาณ (ต่อหน่วย)"
      #       end
      #     end
      #     estimate.each do |stuff|
      #       if stuff["amount"] != ""
      #         tr do
      #           td do
      #             stuff["size"]
      #           end
      #           td do
      #             stuff["amount"]
      #           end
      #           td do
      #             stuff["price_per_unit"]
      #           end
      #         end
      #       end
      #     end
      #   end
      # end

    end

    # panel "ราคารวม จาก estimate cost" do
    #
    #
    #   attributes_table_for quotation do
    #     total = 0
    #     quotation.json_estimate_cost().each do |total|
    #       total = total['amount']
    #     end
    #     row "ราคารวม" do
    #
    #     end
    #   end
    #
    # end

    panel "จำนวน" do
      attributes_table_for quotation do
        row "จำนวน" do

          # stuff = quotation.json_estimate_cost()
          # if stuff != []
          #   table do
          #     tr do
          #       th do
          #         "ขนาด"
          #       end
          #       th do
          #         "จำนวน"
          #       end
          #     end
          #     stuff.each do |price|
          #       if price['amount'] != ""
          #         tr do
          #           td class:"" do
          #             price['size']
          #           end
          #           td class:"" do
          #             price['amount']
          #           end
          #         end
          #       end
          #     end
          #   end
          # end

          quotation = Quotation.find(params[:id])
          if !quotation.nil?
            table do
              tr do
                th do
                  "ขนาด"
                end
                th do
                  "จำนวน"
                end
                # th do
                #   "ราคา"
                # end
              end
              QuotationPrice.where({quotation:quotation}).each do |quotation_price|

                tr do
                  td class:"" do
                    quotation_price.name
                  end
                  td class:"" do
                    quotation_price.amount
                  end
                  # td class:"" do
                  #   quotation_price.price
                  # end
                end

              end
            end
          end

        end
      end
    end


    # panel "ราคารวม" do
    #   attributes_table_for quotation do
    #     # row "ราคารวม" do
    #     #   stuff = order.json_price_amount_report()
    #     #   if stuff != []
    #     #     stuff['total_price']
    #     #   end
    #     # end
    #     row "ราคารวม" do
    #       quotation.total_price
    #     end
    #   end
    # end


    if current_admin_user.group_role.name == "superadmin"

      panel "SUPER ADMIN" do
        stuff = quotation.json_price_amount_report()
        attributes_table_for quotation do

          row "ราคาทุน" do
            if stuff != []
              stuff['price_before_profit']
            end
          end
          row "กำไร" do
            if stuff != []
              stuff['profit']
            end
          end
          # row "ราคาทุน x กำไร" do
          #   if stuff != []
          #     stuff['total_price']
          #   end
          # end
        end
      end

      panel "SUPER ADMIN" do
        attributes_table_for quotation do

          row "ราคาต้นทุน" do

            table do
              tr do
                th do
                  "ชื่อ"
                end
                th do
                  "ราคาแยกตามส่วน"
                end
              end
              json_price = quotation.json_price_amount_report();
              if json_price != []
                all_stuff_price = json_price['all_stuff_price']
              else
                all_stuff_price = []
              end
              all_stuff_price.each do |stuff|
                tr do

                  td do
                    stuff[0]
                  end
                  td do
                    table do
                      tr do
                        th do
                          "Name"
                        end
                        th do
                          "Value"
                        end
                      end
                      stuff[1].each do |key, array|
                        # if !array['fabric_price'].nil?
                        tr do
                          td do
                            if key=="add_option_price"
                              "ค่าเพิ่มเติม"
                            elsif key=="wage"
                              "ค่าแรง (Wage)"
                            elsif key=="base_price"
                              "ราคารวมแต่ละชิ้นส่วน (Base_price)"
                            elsif key=="pattern_price	"
                              "ค่าแบบ (Pattern price)"
                            elsif key=="amount"
                              "จำนวนที่สั่ง (Amount)"
                            elsif key=="profit"
                              "กำไร (Profit)"
                            elsif key=="all_logo_price"
                              "ราคา โลโก้ทุกส่วน (ต่อตัว)"
                            elsif key=="pattern_price / amount"
                              "pattern_price / amount"
                            elsif key=="current_price"
                              "ราคาสุทธิต่อตัว"
                            elsif key=="total_amount_price"
                              "ราคาสุทธิ x จำนวน"
                            else
                              key
                            end
                          end
                          td do
                            if array.class == Hash

                              table do
                                tr do
                                  th do
                                    "fabric_price"
                                  end
                                  th do
                                    "color_factor"
                                  end
                                  th do
                                    "texture_consumption"
                                  end
                                  th do
                                    "consumption"
                                  end
                                  th do
                                    "size_factor"
                                  end
                                  th do
                                    "static_price_per_stuff"
                                  end
                                  th do
                                    "CC_0_price"
                                  end
                                  th do
                                    "CC_1_price"
                                  end
                                  th do
                                    "CC_2_price"
                                  end
                                  th do
                                    "CR_0"
                                  end
                                  th do
                                    "CR_1"
                                  end
                                  th do
                                    "CR_2"
                                  end
                                end
                                tr do
                                  td do
                                    array['fabric_price']
                                  end
                                  td do
                                    array['color_factor']
                                  end
                                  td do
                                    array['stuff_texture_consumption']
                                  end
                                  td do
                                    array['consumption']
                                  end
                                  td do
                                    array['size_factor']
                                  end
                                  td do
                                    array['static_price_per_stuff']
                                  end
                                  td do
                                    array['color_code_0_price']
                                  end
                                  td do
                                    array['color_code_1_price']
                                  end
                                  td do
                                    array['color_code_2_price']
                                  end
                                  td do
                                    array['color_ratio_0']
                                  end
                                  td do
                                    array['color_ratio_1']
                                  end
                                  th do
                                    array['color_ratio_2']
                                  end
                                end
                              end
                            else
                              array.to_f.round(2)
                            end
                          end
                        end
                      end
                    end
                  end

                end
              end #LOOP
            end

            nil
          end
        end
      end
    end #if admin
    active_admin_comments
  end


  form do |f|
    f.semantic_errors # shows errors on :base

    panel "ข้อมูล", :class => 'form-sidebar' do
      f.actions
    end

    f.inputs do
      f.input :admin_user,label:'ผู้ดูแล'
      f.input :credit
      f.input :pledge,label:'Deposit'
      f.input :total_price,label:'ราคารวม (ทุน+กำไร)'
      # f.input :final_price,label:'ราคาสุดท้าย'
      f.input :first_name,label:'ชื่อ'
      f.input :tel,label:'โทร'
      f.input :fax,label:'แฟกซ์'
      f.input :email,label:'อีเมล'
      f.input :address,label:'ที่อยู่'
      # f.input :status
      # f.input :estimate_cost
      # f.input :stuff_picker
      # f.input :base_price
      f.input :company_name,label:'บริษัท'
      f.input :company_branch,label:'สาขา'
      f.input :tax_identification_number,label:'เลขผู้เสียภาษี'
      # f.input :price_amount_report
      f.input :active
    end

    # f.has_many :quotation_prices do |quotation_price|
    #   quotation_price.input :name,label:'ชื่อ',   :wrapper_html => { :class => 'admin-inline' }
    #   quotation_price.input :amount,label:'จำนวน',   :wrapper_html => { :class => 'admin-inline' }
    #   quotation_price.input :price,label:'ราคา',   :wrapper_html => { :class => 'admin-inline',:disabled => true }
    #   # quotation_price.input :_destroy,label:'ลบ', as: :boolean,   :wrapper_html => { :class => 'admin-inline' }
    #   # quotation_price.input :price
    # end





  end



end