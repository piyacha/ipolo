module API
  module V1
    class Creates < Grape::API
      include API::V1::Defaults
      require 'date'

      resource :creates do
        #*********************************************
        #************  Create stuff
        #*********************************************
        desc "Create stuff"
        params do
          requires :type_id, type: String, desc: ""
        end
        get "subBarClick", root: :creates do
          stuff_type = StuffType.find(permitted_params[:type_id])
          subBar = Stuff.where({:stuff_type => stuff_type}).where({:active => true})
          subBars = []
          if !subBar.nil?
            subBar.each do |sub|
              eachStuff = {
                  'id':sub.id,
                  'type':sub.stuff_type.name,
                  'name':sub.name,
                  'desc':sub.desc,
                  'price':sub.price,
                  'img':sub.stuff_img.url(:thumb),
                  'belong_to_type':sub.belong_to_type,
                  'priority':sub.priority
              }
              subBars.push(eachStuff)
            end
          end
          {data:subBars,delete_stuff_button:stuff_type.delete_stuff_button}
        end
      end

      resource :creates do
        #*********************************************
        #************  Find stuff
        #*********************************************
        desc "Find stuff"
        params do
          requires :stuff_id, type: String, desc: ""
        end
        get "find_stuff", root: :creates do

          stuff_found = {}
          stuff = Stuff.find(permitted_params[:stuff_id])
          if !stuff.nil?

            stuff_type_id = stuff.stuff_type.id

            stuffType = StuffType.find(stuff_type_id);
            if stuffType
              stuff_priority = stuffType.priority
            end

            stuff_type_name = stuff.stuff_type.name
            stuff_found = {
                "stuff_type_id":stuff_type_id,
                "stuff_type_name":stuff_type_name,
                "stuff_type_priority":stuff_priority,
                "stuff_price":stuff.price,
                "stuff_additional_price":stuff.additional_price,
                "stuff_name":stuff.name,
                "stuff":stuff,
                "stuff_img":stuff.stuff_img.url(:thumb),
                "stuff_product_img":stuff.stuff_product_img.url(),
                "stuff_product_img_two":stuff.stuff_product_img_two.url(),
                "stuff_product_img_three":stuff.stuff_product_img_three.url(),
                "color_ratio_0":stuff.color_ratio_0,
                "color_ratio_1":stuff.color_ratio_1,
                "color_ratio_2":stuff.color_ratio_2
            }
            color_layer_0 = StuffColor.where({:stuff_type => stuff.stuff_type}).where({:color_layer => 0}).where({:name => "White"}).first
            color_layer_1 = StuffColor.where({:stuff_type => stuff.stuff_type}).where({:color_layer => 1}).where({:name => "White"}).first
            color_layer_2 = StuffColor.where({:stuff_type => stuff.stuff_type}).where({:color_layer => 2}).where({:name => "White"}).first
          end
          {data:stuff_found,color_layer_0:color_layer_0,color_layer_1:color_layer_1,color_layer_2:color_layer_2,type_id:stuff.stuff_type.id}
        end
      end

      resource :creates do
        #*********************************************
        #************  Find stuff color
        #*********************************************
        desc "Find stuff color"
        params do
          requires :type_id, type: String, desc: ""
          requires :stuff_id, type: String, desc: ""
        end
        get "stuff_color", root: :creates do

          stufftype = StuffType.find(permitted_params[:type_id])
          stuff = Stuff.find(permitted_params[:stuff_id])
          # stuff = Stuff.find(permitted_params[:stuff_id])
          color_code = []
          color_code2 = []
          color_code3 = []
          if stufftype #and stuff
            # colors = StuffColor.where({:active => true}).where({:stuff_type => stufftype}).where({:stuff => stuff}).order('priority DESC')
            colors = StuffColor.where({:active => true}).where({:stuff_type => stufftype}).order('priority ASC')
            colors.each do |color|
              tmp = {
                  "id":color.id,
                  "name":color.name,
                  "color_code":color.color_code
              }
              if color.color_layer == 0
                color_code.push(tmp)
              elsif color.color_layer == 1
                color_code2.push(tmp)
              elsif color.color_layer == 2
                color_code3.push(tmp)
              end
            end
          end

          color1 = true
          color2 = true
          color3 = true

          if stuff.stuff_product_img.blank?
            color1 = false
          end
          if stuff.stuff_product_img_two.blank?
            color2 = false
          end
          if stuff.stuff_product_img_three.blank?
            color3 = false
          end

          {data:color_code,layer_two:color_code2,layer_three:color_code3,color1:color1,color2:color2,color3:color3}
        end
      end

      resource :creates do
        #*********************************************
        #************  Find stuff color
        #*********************************************
        desc "Find color"
        params do
          requires :color_id, type: String, desc: ""
        end
        get "find_color", root: :creates do
          color = StuffColor.find(permitted_params[:color_id])
          color_code = ""
          color_name = ""
          color_price = 0
          if color
            color_code = color.color_code
            color_name = color.name
            color_price = color.color_price
          end
          {data:color_code,name:color_name,color_price:color_price}
        end
      end

      resource :creates do
        #*********************************************
        #************  Find stuff color
        #*********************************************
        desc "Find color"
        params do
          requires :order_id, type: String, desc: ""
          requires :user_id, type: String, desc: ""
          requires :phone, type: String, desc: ""
          requires :slip, type: File, desc: ""
          requires :payment_name, type: String, desc: ""
          requires :bank_account_id, type: String, desc: ""
          requires :paid_amount, type: String, desc: ""
          requires :paid_at, type: String, desc: ""
        end
        post "payment_transfer", root: :creates do
          payment = Payment.new
          payment.image = permitted_params[:slip][:tempfile]
          payment.order = Order.find_by(id: permitted_params[:order_id])
          payment.user = User.find_by(id: permitted_params[:user_id])
          payment.name = permitted_params[:payment_name] || ""
          payment.phone = permitted_params[:phone] || ""
          payment.bank_account = BankAccount.find_by(id: permitted_params[:bank_account_id])
          payment.paid_amount = permitted_params[:paid_amount]
          payment.paid_at = DateTime.parse(permitted_params[:paid_at])
          p "========== payment.bank_account #{payment.bank_account}"
          payment.save!
        end
      end

      resource :creates do
        #*********************************************
        #************  Find find_stuff_size
        #*********************************************
        desc "Find find_stuff_size"
        params do
          requires :stuff_id, type: String, desc: ""
        end
        get "find_stuff_size", root: :creates do
          stuff = Stuff.find(permitted_params[:stuff_id])
          stuffSize_male   = StuffSize.where({:stuff => stuff,:sex => "male"}).order('priority ASC')
          stuffSize_female = StuffSize.where({:stuff => stuff,:sex => "female"}).order('priority ASC')

          male_size        = StaticValue.where({:key => "male_size"}).first
          female_size      = StaticValue.where({:key => "female_size"}).first
          if male_size && female_size
            male_image        = male_size.image.url() if male_size.image
            female_image      = female_size.image.url() if female_size.image
  
            male_size = {
              value: male_size.value,
              image: male_image
            }
  
            female_size = {
              value: female_size.value,
              image: female_image
            }
          end
          
          { data_stuffSize_male: stuffSize_male, data_stuffSize_female: stuffSize_female, male_size: male_size, female_size: female_size }
        end
      end

      resource :creates do
        #*********************************************
        #************  Find stuff profit
        #*********************************************
        desc "Find stuff profit"
        params do
          # requires :stuff_id, type: String, desc: ""
        end
        get "stuff_profit", root: :creates do
          stuff_profit = StuffProfit.where({active:true})
          {stuff_profit:stuff_profit}
        end
      end

      resource :creates do
        #*********************************************
        #************  Find stuff profit
        #*********************************************
        desc "Find logo static value"
        params do
          # requires :stuff_id, type: String, desc: ""
        end
        get "logo_static_value", root: :creates do
          logo_static_value = LogoStaticValue.where({active:true})
          {logo_static_value:logo_static_value}
        end
      end

      resource :creates do
        #*********************************************
        #************  Find find_stuff_size
        #*********************************************
        desc "Find find_stuff_size"
        params do
          optional :type_id, type: String, desc: ""
        end
        get "prepare_default_stuff", root: :creates do

          stuffType_type = StuffType.where({:name => "TYPE"}).first
          stuffNeck_type = StuffType.where({:name => "NECK"}).first
          stuffBody_type = StuffType.where({:name => "BODY"}).first
          stuffSleeve_type = StuffType.where({:name => "ARM"}).first
          stuffPlacket_type = StuffType.where({:name => "PLACKET"}).first
          stuffBotton_type = StuffType.where({:name => "BOTTON"}).first
          if permitted_params[:type_id] == "-99"
            stuffNeck = Stuff.where(:stuff_type => stuffNeck_type).order('priority DESC').first
            stuffType = Stuff.where(:stuff_type => stuffType_type).order('priority DESC').first
            stuffBody = Stuff.where(:stuff_type => stuffBody_type).order('priority DESC').first
            stuffSleeve = Stuff.where(:stuff_type => stuffSleeve_type).order('priority DESC').first
            stuffBotton = Stuff.where(:stuff_type => stuffBotton_type).order('priority DESC').first
            stuffPlacket = Stuff.where(:stuff_type => stuffPlacket_type).order('priority DESC').first
            stuffTexture = StuffTexture.where(:active => true).order('priority DESC').first
            {
                type_side:stuffType_type,
                neck:stuffNeck,
                type:stuffType,
                body:stuffBody,
                texture:stuffTexture,
                placket:stuffPlacket,
                sleeve:stuffSleeve,
                botton:stuffBotton,
                neck_type_id:stuffNeck_type.id,
                body_type_id:stuffBody_type.id,
                placket_type_id:stuffPlacket_type.id,
                sleeve_type_id:stuffSleeve_type.id,
                botton_type_id:stuffBotton_type.id
            }
          else
            stuff = Stuff.where(:belong_to_type => permitted_params[:type_id]).first
            stuffNeck = Stuff.where(:stuff_type => stuffNeck_type).where(:belong_to_type => permitted_params[:type_id]).order('priority DESC').first
            stuffType = Stuff.where(:stuff_type => stuffType_type).where(:belong_to_type => permitted_params[:type_id]).order('priority DESC').first
            stuffBody = Stuff.where(:stuff_type => stuffBody_type).where(:belong_to_type => permitted_params[:type_id]).order('priority DESC').first
            stuffSleeve = Stuff.where(:stuff_type => stuffSleeve_type).where(:belong_to_type => permitted_params[:type_id]).order('priority DESC').first
            stuffPlacket = Stuff.where(:stuff_type => stuffPlacket_type).where(:belong_to_type => permitted_params[:type_id]).order('priority DESC').first
            stuffBotton = Stuff.where(:stuff_type => stuffBotton_type).where(:belong_to_type => permitted_params[:type_id]).order('priority DESC').first
            stuffTexture = StuffTexture.where(:active => true).where(:stuff => stuff).order('priority DESC').first
            {
              type_side:stuffType_type,
              neck:stuffNeck,
              type:stuffType,
              body:stuffBody,
              texture:stuffTexture,
              placket:stuffPlacket,
              sleeve:stuffSleeve,
              botton:stuffBotton,
              neck_type_id:stuffNeck_type.id,
              body_type_id:stuffBody_type.id,
              placket_type_id:stuffPlacket_type.id,
              sleeve_type_id:stuffSleeve_type.id,
              botton_type_id:stuffBotton_type.id
            }
          end
        end
      end

      resource :creates do
        #*********************************************
        #************  Find find_texture
        #*********************************************
        desc "Find find_texture"
        params do
          requires :texture_id, type: String, desc: ""
        end
        get "find_texture", root: :creates do
          stuffTexture = StuffTexture.find(permitted_params[:texture_id])
          if stuffTexture && stuffTexture.stuff_texture_img
            {data:stuffTexture,img:stuffTexture.stuff_texture_img.url(:thumb)}
          end
        end
      end


      resource :creates do
        #*********************************************
        #************  Random Color by stuff
        #*********************************************
        desc "Random Color by stuff"
        params do
          requires :stuff_id, type: String, desc: ""
        end
        get "random_color_by_stuff", root: :creates do
          stuff = Stuff.find(permitted_params[:stuff_id])
          # randColor_layer_0 = StuffColor.where({:stuff_type => stuff.stuff_type}).where({:color_layer => 0}).order("RANDOM()").first
          # randColor_layer_1 = StuffColor.where({:stuff_type => stuff.stuff_type}).where({:color_layer => 1}).order("RANDOM()").first
          randColor_layer_0 = StuffColor.where({:stuff_type => stuff.stuff_type}).where({:color_layer => 0}).where({:name => "White"}).first
          randColor_layer_1 = StuffColor.where({:stuff_type => stuff.stuff_type}).where({:color_layer => 1}).where({:name => "White"}).first
          {randColor_0:randColor_layer_0,randColor_1:randColor_layer_1,typeName:stuff.stuff_type.name,type_id:stuff.stuff_type.id}
        end
      end

      resource :creates do
        #*********************************************
        #************  save logo img
        #*********************************************
        desc "Find logo img"
        params do
          requires :img, type: File, desc: ""
          requires :color_number, type: String, desc: ""
          requires :logo_type, type: String, desc: ""
          requires :logo_width, type: String, desc: ""
          requires :logo_height, type: String, desc: ""

        end
        post "save_logo_img", root: :creates do

          newLogo = StuffLogo.new
          newLogo.stuff_logo_img = permitted_params[:img][:tempfile]
          newLogo.color_number = permitted_params[:color_number]

          newLogo.logo_type = permitted_params[:logo_type]
          newLogo.logo_width = permitted_params[:logo_width]
          newLogo.logo_height = permitted_params[:logo_height]

          newLogo.save

          if newLogo
            {data:newLogo,img_thumb:newLogo.stuff_logo_img.url(:thumb),img_original:newLogo.stuff_logo_img.url()}
          end

        end
      end

      resource :creates do
        #*********************************************
        #************  default texture
        #*********************************************
        desc "default_texture (MUST BE TYPE ID)"
        params do
          requires :stuff_id, type: String, desc: ""
        end
        get "default_texture", root: :creates do


          stuff_id = Stuff.find(permitted_params[:stuff_id])
          if stuff_id
            texture = StuffTexture.where({:active => true}).order('priority DESC').first
            { id:texture.id }
          else
            { id:nil }
          end

        end
      end


      resource :creates do
        #*********************************************
        #************  Find find_stuff_size
        #*********************************************
        desc "find_stuff_texture_size"
        params do
          requires :stuff_id, type: String, desc: ""
        end
        get "find_stuff_texture_size", root: :creates do

          stuff = Stuff.find(permitted_params[:stuff_id])
          stuffTexture = StuffTexture.where({:stuff => stuff}).where({:active => true})
          stuffSize = StuffSize.where({:stuff => stuff}).where({:active => true})
          stuffColor = StuffColor.where({:stuff => stuff}).where({:active => true})
          texture = []
          size = []
          if stuffTexture && stuffSize
            stuffTexture.each do |st|
              tmp = {
                  "id":st.id,
                  "name":st.name,
                  "img":st.stuff_texture_img.url(:thumb),
                  "priority":st.priority
              }
              texture.push(tmp)
            end
            stuffSize.each do |sz|
              tmp = {
                  "id":sz.id,
                  "name":sz.name,
                  "sex":sz.sex,
                  "base_price":sz.base_price,
                  "priority":sz.priority,
                  "add_option_price":sz.add_option_price,
                  "pattern_price":sz.pattern_price
              }
              size.push(tmp)
            end
            stuff_type = { texture:texture ,size:size }
            if stuff.stuff_product_img_two
              stuff_type["promotion"] = stuff.stuff_product_img_two.url()
            end
            stuff_type
          end

        end
      end

      resource :creates do
        #*********************************************
        #************  Find find_texture
        #*********************************************
        desc "make_order"
        params do
          optional :order_id, type: String, desc: ""
          optional :first_name, type: String, desc: ""
          optional :address, type: String, desc: ""
          optional :tel, type: String, desc: ""
          optional :fax, type: String, desc: ""
          optional :email, type: String, desc: ""

          optional :estimate_cost, type: String, desc: ""
          optional :stuff_picker, type: String, desc: ""
          optional :stuff_price, type: String, desc: ""
          optional :base_price, type: String, desc: ""
          optional :price_amount_report, type: String, desc: ""

          optional :company_name, type: String, desc: ""
          optional :company_branch, type: String, desc: ""
          optional :tax_identification_number, type: String, desc: ""

          optional :option_price_details, type: String, desc: ""
          optional :current_user_id, type: String, desc: ""
          optional :current_admin_user_email, type: String, desc: ""
        end
        post "make_order", root: :creates do
          user = User.find_by(id: permitted_params[:current_user_id]) 
          order = Order.find_by(id: permitted_params[:order_id]) if permitted_params[:order_id]
          
          if order
            newOrder = order
          else
            newOrder = Order.new
          end  

          if permitted_params[:current_admin_user_email]
            adminUser = AdminUser.where({email:permitted_params[:current_admin_user_email]}).first;
          else
            adminUser = AdminUser.where({username:"anonymous"}).first;
          end

          newOrder.admin_user     = adminUser
          newOrder.user           = user
          newOrder.first_name     = permitted_params[:first_name]
          newOrder.address        = permitted_params[:address]
          newOrder.tel            = permitted_params[:tel]
          newOrder.fax            = permitted_params[:fax]
          newOrder.email          = permitted_params[:email]

          newOrder.estimate_cost  = permitted_params[:estimate_cost]
          newOrder.stuff_picker   = permitted_params[:stuff_picker]
          newOrder.stuff_price    = permitted_params[:stuff_price]
          newOrder.base_price     = permitted_params[:base_price]
          newOrder.price_amount_report = permitted_params[:price_amount_report]

          if permitted_params[:price_amount_report]
            price_json = JSON.parse(permitted_params[:price_amount_report])
            newOrder.total_price = (price_json['total_price']).to_f
          else
            # FOR STUFF EXISTED
            price_json = JSON.parse(permitted_params[:estimate_cost])
            total = 0
            price_json.each do |price|
              total = total + (price['amount'].to_f * price['price_per_unit'].to_f)
            end
            newOrder.total_price = total
          end

          newOrder.company_name   = permitted_params[:company_name]
          newOrder.company_branch = permitted_params[:company_branch]
          newOrder.tax_identification_number = permitted_params[:tax_identification_number]

          newOrder.option_price_details = permitted_params[:option_price_details]
          newOrder.save

          { order_id: newOrder.id }
        end
      end

      resource :creates do
        #*********************************************
        #************  save logo img
        #*********************************************
        desc "save_order_img"
        params do
          requires :order_id, type: String, desc: ""
          requires :img, type: File, desc: ""
        end
        post "save_order_img", root: :creates do
          order = Order.find(permitted_params[:order_id])
          if order
            order.stuff_img = permitted_params[:img][:tempfile]
            order.save
            {order_id: order.id, status:true}
          else
            {status:false}
          end

        end
      end

      resource :creates do
        #*********************************************
        #************  make_quotation
        #*********************************************
        desc "make_quotation"
        params do
          requires :order_id, type: String, desc: ""
        end
        post "make_quotation", root: :creates do
          order = Order.find(permitted_params[:order_id])
          if order
            quotation = Quotation.new
            quotation.first_name     = order.first_name
            quotation.address        = order.address
            quotation.tel            = order.tel
            quotation.fax            = order.fax
            quotation.email          = order.email
            quotation.stuff_img      = order.stuff_img
            quotation.estimate_cost  = order.estimate_cost
            quotation.stuff_picker   = order.stuff_picker
            quotation.stuff_price    = order.stuff_price
            quotation.base_price     = order.base_price
            quotation.company_name   = order.company_name
            quotation.company_branch = order.company_branch
            quotation.price_amount_report = order.price_amount_report
            quotation.option_price_details = order.option_price_details
            quotation.tax_identification_number = order.tax_identification_number
            quotation.admin_user = order.admin_user
            quotation.total_price = order.total_price

            if order.price_amount_report
              price_amount_report = JSON.parse(order.price_amount_report)['all_stuff_price']
              price_amount_report.keys.each do |size|
                if price_amount_report[size]['amount'] != ""
                  quotation_price = QuotationPrice.new
                  quotation_price.quotation = quotation
                  quotation_price.name = size
                  quotation_price.amount = price_amount_report[size]['amount'].to_i
                  quotation_price.price = price_amount_report[size]['current_price'].to_f
                  quotation_price.save
                end
              end
            else
              price_json = JSON.parse(permitted_params[:estimate_cost])
              price_json.each do |price|
                quotation_price = QuotationPrice.new
                quotation_price.quotation = quotation
                quotation_price.name = price['size']
                quotation_price.amount = price['amount'].to_i
                quotation_price.price = price['price_per_unit'].to_f
                quotation_price.save
              end
            end


            if quotation.credit.nil?
              credit = Credit.order("priority DESC").first
              quotation.credit = credit
            else
              credit = quotation.credit
            end
            if quotation.pledge.nil?
              pledge = Pledge.order("priority DESC").first
              quotation.pledge = pledge
            else
              pledge = quotation.pledge
            end
            quotation.final_price = (quotation.total_price * credit.value * pledge.value).round(1)

            quotation.save

            # @quotation = quotation
            # AdminMailer.send_quotation(@quotation).deliver

            order.status = "quotation"
            order.save
            {status:true,quotation_id:quotation.id}
          else
            {status:false}
          end
        end
      end

      resource :creates do
        #*********************************************
        #************  make_contact
        #*********************************************
        desc "make_contact"
        params do
          requires :order_id, type: String, desc: ""
        end
        post "make_contact", root: :creates do
          order = Order.find(permitted_params[:order_id])
          if order
            order.status = "contact"
            order.save
            {status:true}
          else
            {status:false}
          end
        end
      end

      resource :creates do
        #*********************************************
        #************  send_email
        #*********************************************
        desc "send_email"
        params do
          requires :quotation_id, type: String, desc: ""
          requires :base_url, type: String, desc: ""
        end
        post "send_email", root: :creates do

          quotation = Quotation.find(permitted_params[:quotation_id])
          if quotation
            @quotation = quotation
            AdminMailer.send_quotation(@quotation.email,@quotation,permitted_params[:base_url]).deliver

            if @quotation.admin_user
              if @quotation.admin_user.email
                AdminMailer.send_quotation(@quotation.admin_user.email,@quotation,permitted_params[:base_url]).deliver
              end
            end

            quotation.complete = true
            quotation.save
            {status:true}
          else
            {status:false}
          end

        end
      end


    end
  end
end
