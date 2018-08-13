ActiveAdmin.register Order do

  menu parent: 'Order',  priority: 1

  filter :first_name
  filter :email
  filter :tel

  permit_params :status, :first_name, :address, :tel ,:email ,:stuff_img ,:note ,:estimate_cost ,:stuff_picker ,:base_price ,:company_name ,:fax ,
                :company_branch ,:tax_identification_number,:option_price_details,:price_amount_report,:admin_user_id,:total_price

  action_item :print, only: [:show] do
    link_to "Print", print_order_path(:id => params[:id],:from => "order"), :target => "_blank"
  end
  action_item "Contact", only: [:show] do
    link_to "Contact", order_make_contact_path(:id => params[:id],:from => "order")
  end
  action_item "Quotation", only: [:show] do
    link_to "Quotation", order_make_quotation_path(:id => params[:id],:from => "order")
  end

  scope "All",  :default => true do |order|
    if current_admin_user.anonymous == true
      Order.all().order('updated_at DESC')
    else
      Order.where({admin_user:current_admin_user}).order('updated_at DESC')
    end
  end
  scope :no_contact do |order|
    if current_admin_user.anonymous == true
      Order.where({:status => "no contact"}).order('updated_at DESC')
    else
      Order.where({admin_user:current_admin_user}).where({:status => "no contact"}).order('updated_at DESC')
    end
  end
  scope :contact do |order|
    if current_admin_user.anonymous == true
      Order.where({:status => "contact"}).order('updated_at DESC')
    else
      Order.where({admin_user:current_admin_user}).where({:status => "contact"}).order('updated_at DESC')
    end
  end
  scope :quotation do |order|
    if current_admin_user.anonymous == true
      Order.where({:status => "quotation"}).order('updated_at DESC')
    else
      Order.where({admin_user:current_admin_user}).where({:status => "quotation"}).order('updated_at DESC')
    end
  end

  index do
    div do stylesheet_link_tag "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" end
    div do javascript_include_tag "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" end
    selectable_column
    # column :id
    column :admin_user
    column :first_name
    column :tel
    column :fax
    column :email
    column "status" do |order|
      if order.status == "quotation"
        span class:'label label-success' do
          "Quotation"
        end
      elsif order.status == "contact"
        span class:'label label-info' do
          "Contact"
        end
      elsif order.status == "no contact"
        span class:'label label-warning' do
          "NO contact"
        end
      end
    end
    column "Make Contact" do |order|
      button type:'button',id:'',class:'btn btn-info order_contact',value:order.id do
        span class:'glyphicon glyphicon-earphone',style:'margin-right:5px' do

        end
        span do
          'Contact'
        end
      end
    end
    column "Make Quotation" do |order|
      button type:'button',id:'order_quotation',class:'btn btn-success order_quotation',value:order.id  do
        span class:'glyphicon glyphicon-transfer',style:'margin-right:5px' do

        end
        span do
          'Quotation'
        end
      end
    end
    column "View" do |order|
      a href:"/admin/orders/#{order.id}" do
        button type:'button',id:'',class:'btn btn-default',value:order.id  do
          span class:'glyphicon glyphicon-search',style:'margin-right:5px' do

          end
          span do
            'View'
          end
        end
      end
    end
    column "Edit" do |order|
      a href:"/admin/orders/#{order.id}/edit" do
        button type:'button',id:'',class:'btn btn-default',value:order.id  do
          span class:'glyphicon glyphicon-cog',style:'margin-right:5px' do

          end
          span do
            'Edit'
          end
        end
      end
    end
    column "Delete" do |order|
      # a href:"/admin/orders/#{order.id}" do
      #   button type:'button',id:'',class:'btn btn-danger',value:order.id  do
      #     'Delete'
      #   end
      # end
      link_to "Delete", admin_order_path(order), :method => :delete, :data => {:confirm => "ยืนยันการลบ ?"},:class => 'btn btn-danger',:style => 'color:white;'
    end

    # actions dropdown: true do |order|
    #   item "Delete", admin_order_path(order), :method => :delete, :data => {:confirm => "Are you sure?"}
    # end

    div class:'modal fade',id:'complete_status',tabindex:'-1',role:'dialog' do
      div class:'modal-dialog',role:'document' do
        div class:'modal-content' do
          div class:'modal-header' do
            h4 class:'modal-title',id:'app-modal-doc-name-confirm' do
              "สถานะ"
            end
          end

          div class:'modal-body' do
            h3 do
              "ทำรายการเรียบร้อย"
            end
          end

          div class:'modal-footer' do
            button type:'button',class:'btn btn-default complete_status_model_close' do
              'ปิด'
            end
          end
        end
      end
    end
  end


  sidebar "ข้อมูลสถานะ", only: :show,class:"order_sidebar" do

    attributes_table do
      row "สถานะ" do |c|
        c.status
      end
      row "รับผิดชอบโดย" do |c|
        c.admin_user
      end
    end

  end

  sidebar "ข้อมูลผู้เสนอราคา", only: :show,class:"order_sidebar" do

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
    order = Order.find(params[:id])
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

  show do

    attributes_table do
      row "รูป สิ้นค้า" do |order|
        div class:"order_center" do
          if order.stuff_img
            image_tag(order.stuff_img.url(:medium))
          end
        end
      end
    end

    panel "รายละเอียด" do

      attributes_table_for order do

        if order.stuff_picker
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
                stuff_picker = JSON.parse(order.stuff_picker)
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
              stuff_picker = JSON.parse(order.stuff_picker)
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
                  th do
                    "ชื่อสีที่ 3"
                  end
                  th do
                    "สีส่วนที่ 3"
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
                          # color_field_tag('color',picker["color_code_0"])
                        else
                          "ไม่พบสี"
                        end
                      end

                      td do
                        if picker["color_code_1_name"]
                          picker["color_code_1_name"]
                        else
                          "ไม่พบชื่อ"
                        end
                      end
                      td do
                        if picker["color_code_1"]
                          # color_field_tag('color',picker["color_code_1"])
                          div style:'background-color:'+picker["color_code_1"]+';width:100px;height:50px;' do
                          end
                        else
                          "ไม่พบสี"
                        end
                      end

                      td do
                        if picker["color_code_2_name"]
                          picker["color_code_2_name"]
                        else
                          "ไม่พบชื่อ"
                        end
                      end
                      td do
                        if picker["color_code_2"]
                          # color_field_tag('color',picker["color_code_1"])
                          div style:'background-color:'+picker["color_code_2"]+';width:100px;height:50px;' do
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

        end
        # end if c.stuff_picker
        row "เพิ่มเติมพิเศษ" do
          order.option_price_details
          # c.base_price
        end
      end

    end

    # panel "ราคา" do
    #   attributes_table_for order do
    #
    #     row "ราคาต้นทุน" do
    #
    #       table do
    #         tr do
    #           th do
    #             "ชื่อ"
    #           end
    #           # th do
    #           #   "ราคาสุทธิต่อตัว"
    #           # end
    #           th do
    #             "จำนวน"
    #           end
    #           th do
    #             "รวม"
    #           end
    #         end
    #         order.json_price_amount_report().each do |stuff|
    #           tr do
    #             td do
    #               stuff[0]
    #             end
    #             # td do
    #             #   stuff[1]['current_price'].to_f.round(2)
    #             # end
    #             td do
    #               stuff[1]['amount']
    #             end
    #             td do
    #               stuff[1]['total_amount_price'].to_f.round(2)
    #             end
    #           end
    #         end
    #       end
    #       nil
    #     end
    #   end
    # end

    panel "จำนวน" do
      attributes_table_for order do
        row "จำนวน" do
          stuff = order.json_estimate_cost()
          if stuff != []
            table do
              tr do
                th do
                  "ขนาด"
                end
                th do
                  "จำนวน"
                end
              end
              stuff.each do |price|
                if price['amount'] != ""
                  tr do
                    td class:"" do
                      price['size']
                    end
                    td class:"" do
                      price['amount']
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    panel "ราคารวม" do
      attributes_table_for order do
        # row "ราคารวม" do
        #   stuff = order.json_price_amount_report()
        #   if stuff != []
        #     stuff['total_price']
        #   end
        # end
        row "ราคารวม" do
          order.total_price
        end
      end
    end

    if current_admin_user.group_role.name == "superadmin"
      panel "SUPER ADMIN" do
        stuff = order.json_price_amount_report()
        attributes_table_for order do

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
          row "ราคาทุน x กำไร" do
            if stuff != []
              stuff['total_price']
            end
          end
        end
      end
      panel "SUPER ADMIN" do
        attributes_table_for order do

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
              json_price = order.json_price_amount_report();
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
                                  td do
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
    f.inputs do
      f.input :admin_user
      f.input :first_name
      f.input :address
      f.input :tel
      f.input :fax
      f.input :email
      # f.input :status
      # f.input :estimate_cost
      # f.input :stuff_picker
      # f.input :base_price
      f.input :company_name
      f.input :company_branch
      f.input :tax_identification_number
      # f.input :price_amount_report
      # f.input :total_price
      f.input :active
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end


end