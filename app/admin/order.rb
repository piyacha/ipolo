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
  scope "ที่มีใบเสนอราคา" do |order|
    if current_admin_user.anonymous == true
      Order.where({:status => "quotation"}).order('updated_at DESC')
    else
      Order.where({admin_user:current_admin_user}).where({:status => "quotation"}).order('updated_at DESC')
    end
  end

  index do
    selectable_column
    # column :admin_user
    column :id
    column :user
    column :first_name
    column :tel
    column :email
    column "สถานะใบเสนอราคา" do |order|
      if order.status == "quotation"
        span class:'label label-primary' do
          "สร้างแล้ว"
        end
      elsif order.status == "contact"
        span class:'label label-info' do
          "ติดต่อแล้ว"
        end
      elsif order.status == "pending"
        span class:'label label-warning' do
          "รอตรวจสอบการแจ้งโอน"
        end
      elsif order.status == "no contact"
        span class:'label label-warning' do
          "ยังไม่สร้าง"
        end
      end
    end
    column "ใบเสนอราคา" do |order|
      if order.status == "quotation" && order.quotations.last
        a href: admin_quotation_path(id: order.quotations.last.id),class:'btn btn-primary' do 
          "ดูใบเสนอราคา"
        end
      else
        button type:'button',id:'order_quotation',class:'btn btn-success order_quotation',value:order.id  do
          span do
            'ยืนยัน'
          end
        end
      end
    end
    actions
  end


  sidebar "ข้อมูลสถานะ", only: :show,class:"order_sidebar" do

    attributes_table do
      row "สถานะ" do |c|
        c.status
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
          table do
            tr do
              th do
                "ชื่อ"
              end
              th do
                "ราคาแยกตามส่วน"
              end
            end
            json_price = order.json_price_amount_report()
            all_stuff_price = []
            all_stuff_price = json_price['all_stuff_price'] if !json_price['all_stuff_price'].nil?
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