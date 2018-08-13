namespace :asset do
  desc "TODO"
  task import: :environment do

    # stuff_types = ["TYPE","BODY","SLEEVES","COLLAR","BOTTOM","PLACKET","POCKET","WRIST","BOTTON","HALF_MOON","LOGO"]
    
    # stuff_types.each do |stuff_type|

    #   st = StuffType.where({name:stuff_type}).first
    
    #   case stuff_type 
    #   when "TYPE"  

    #     stuff = Stuff.where(name:"TYPE_polo").first
    #     stuff.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-type_polo.png").open
    #     stuff.stuff_product_img = Rails.root.join("ipolo_stuff/icon/blank.png").open
    #     stuff.stuff_product_img_two = Rails.root.join("ipolo_stuff/icon/blank.png").open
    #     stuff.save

    #     stuff = Stuff.where(name:"TYPE_tshirt").first
    #     stuff.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-type_tshirt.png").open
    #     stuff.stuff_product_img = Rails.root.join("ipolo_stuff/icon/blank.png").open
    #     stuff.stuff_product_img_two = Rails.root.join("ipolo_stuff/icon/blank.png").open
    #     stuff.save

    #   when "BODY"
        
    #   else

    #   end

    # end

    stuff_type = StuffType.where({name:"BODY"}).first

    body_9 = Stuff.new
    body_9.name = "BODY_9"
    body_9.desc = "BODY_9"
    body_9.stuff_type  = stuff_type
    body_9.belong_to_type = "80"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_9.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_9.png").open
    # body_9.stuff_product_img_three = Rails.root.join("ipolo_stuff/process/Artboard-9-base.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_10"
    body_9.desc = "BODY_10"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "80"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_10.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_10.png").open
    body_9.stuff_product_img_three = Rails.root.join("ipolo_stuff/process/Artboard-1-base_10_2.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_11"
    body_9.desc = "BODY_11"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "80"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_11.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_11.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_12"
    body_9.desc = "BODY_12"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "80"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_12.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_12.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_13"
    body_9.desc = "BODY_13"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "80"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_13.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_13.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_14"
    body_9.desc = "BODY_14"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "80"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_14.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_14.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_15"
    body_9.desc = "BODY_15"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "80"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_15.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_15.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_16"
    body_9.desc = "BODY_16"
    body_9.belong_to_type = "80"
    body_9.stuff_type = stuff_type
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_16.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_16.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_17"
    body_9.desc = "BODY_17"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "80"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_17.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_17.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_18"
    body_9.desc = "BODY_18"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "80"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_18.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_18.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_19"
    body_9.desc = "BODY_19"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "80"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_19.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_19.png").open
    body_9.stuff_product_img_three = Rails.root.join("ipolo_stuff/process/Artboard-1-base_19_2.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_20"
    body_9.desc = "BODY_20"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "80"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_20.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_20.png").open
    body_9.save
    
    
    ###############################################################################################################
    
    body_9 = Stuff.new
    body_9.name = "BODY_9_T"
    body_9.desc = "BODY_9_T"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "81"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_9.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_9.png").open
    # body_9.stuff_product_img_three = Rails.root.join("ipolo_stuff/process/Artboard-9-base.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_10_T"
    body_9.desc = "BODY_10_T"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "81"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_10.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_10.png").open
    body_9.stuff_product_img_three = Rails.root.join("ipolo_stuff/process/Artboard-1-base_10_2.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_11_T"
    body_9.desc = "BODY_11_T"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "81"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_11.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_11.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_12_T"
    body_9.desc = "BODY_12_T"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "81"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_12.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_12.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_13_T"
    body_9.desc = "BODY_13_T"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "81"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_13.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_13.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_14_T"
    body_9.desc = "BODY_14_T"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "81"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_14.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_14.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_15_T"
    body_9.desc = "BODY_15_T"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "81"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_15.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_15.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_16_T"
    body_9.desc = "BODY_16_T"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "81"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_16.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_16.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_17_T"
    body_9.desc = "BODY_17_T"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "81"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_17.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_17.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_18_T"
    body_9.desc = "BODY_18_T"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "81"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_18.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_18.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_19_T"
    body_9.desc = "BODY_19_T"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "81"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_19.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_19.png").open
    body_9.stuff_product_img_three = Rails.root.join("ipolo_stuff/process/Artboard-1-base_19_2.png").open
    body_9.save
    
    body_9 = Stuff.new
    body_9.name = "BODY_20_T"
    body_9.desc = "BODY_20_T"
    body_9.stuff_type = stuff_type
    body_9.belong_to_type = "81"
    body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_20.png").open
    body_9.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/process/Artboard-1-base_20.png").open
    body_9.save


  end

end
