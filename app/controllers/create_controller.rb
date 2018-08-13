class CreateController < ApplicationController

  def index

    @stuffType = StuffType.where(:active => true).order('priority ASC')
    @stuffSize = StuffSize.where(:active => true).order('priority DESC')

  end

  def how_to

  end

  def existed

    @existed = []
    StuffExist.where({:active => true}).all.each do |stuff_exist|
      stuffExistSize = StuffExistSize.where({stuff_exist:stuff_exist})
      if !stuffExistSize.nil?
        size = []
        stuffExistSize.each do |stuff_exist_size|
          size.push({'name':stuff_exist_size.name,
              'sex':stuff_exist_size.sex,
              'price':stuff_exist_size.price,
              'priority':stuff_exist_size.priority })
        end
        if size.length != 0
          @existed.push({'id':stuff_exist.id,
          'name':stuff_exist.name,
          'size':size,
          'desc':stuff_exist.desc,
          'stuff_exist_img':stuff_exist.stuff_exist_img.url()
          })
        end
      end
    end
    @existed

  end

  def custom_db

    # if stuffAll.length > 0
    #   StuffColor.all().destroy_all
    # end

    # StuffColor.all().each do |stuff_all|
    #   if stuff_all.name == "Black"
    #     stuff_all.color_code = "#1e1e1e"
    #   end
    #   if stuff_all.name == "Cerment"
    #     stuff_all.color_code = "#626262"
    #   end
    #   if stuff_all.name == "Smoke"
    #     stuff_all.color_code = "#c0c0c0"
    #   end
    #
    #   if stuff_all.name == "Scuba Blue"
    #     stuff_all.color_code = "#27bad3"
    #   end
    #
    #   if stuff_all.name == "Dark Purple"
    #     stuff_all.color_code = "#3d036b"
    #   end
    #
    #   if stuff_all.name == "Blooming Rose"
    #     stuff_all.color_code = "#612862"
    #   end
    #
    #   if stuff_all.name == "Chocolate"
    #     stuff_all.color_code = "#362727"
    #   end
    #
    #
    #   if stuff_all.name == "Khaki"
    #     stuff_all.color_code = "#92806d"
    #   end
    #
    #   if stuff_all.name == "Oatmeal"
    #     stuff_all.color_code = "#ebd7bc"
    #   end
    #
    #   if stuff_all.name == "Lilac"
    #     stuff_all.color_code = "#9a6ce6"
    #   end
    #
    #   if stuff_all.name == "Shocking Pink"
    #     stuff_all.color_code = "#e00c5b"
    #   end
    #
    #   if stuff_all.name == "Carnation Pink"
    #     stuff_all.color_code = "#ff80c0"
    #   end
    #
    #   if stuff_all.name == "Dark Green"
    #     stuff_all.color_code = "#214e26"
    #   end
    #
    #   if stuff_all.name == "Green Apple"
    #     stuff_all.color_code = "#61be6c"
    #   end
    #
    #   if stuff_all.name == "LEAF"
    #     stuff_all.color_code = "#abff79"
    #   end
    #
    #   if stuff_all.name == "Baby Pink"
    #     stuff_all.color_code = "#ffaed7"
    #   end
    #
    #   if stuff_all.name == "Burgundy"
    #     stuff_all.color_code = "#59151b"
    #   end
    #
    #   if stuff_all.name == "Cherry"
    #     stuff_all.color_code = "#9e0505"
    #   end
    #
    #   if stuff_all.name == "Deep Navy"
    #     stuff_all.color_code = "#030040"
    #   end
    #
    #   if stuff_all.name == "Shocking Blue"
    #     stuff_all.color_code = "#00107d"
    #   end
    #
    #   if stuff_all.name == "Pacific Blue"
    #     stuff_all.color_code = "#303ffa"
    #   end
    #
    #   if stuff_all.name == "Peach"
    #     stuff_all.color_code = "#ff5e46"
    #   end
    #
    #   if stuff_all.name == "Chocolate"
    #     stuff_all.color_code = "#362727"
    #   end
    #
    #   if stuff_all.name == "Orange Sherbet"
    #     stuff_all.color_code = "#ffb08a"
    #   end
    #
    #   if stuff_all.name == "French Blue"
    #     stuff_all.color_code = "#0065ca"
    #   end
    #
    #   if stuff_all.name == "School Blue"
    #     stuff_all.color_code = "#77bbff"
    #   end
    #
    #   if stuff_all.name == "PVC Blue"
    #     stuff_all.color_code = "#00ffff"
    #   end
    #
    #   if stuff_all.name == "Ratchaphruk"
    #     stuff_all.color_code = "#ffff00"
    #   end
    #
    #   if stuff_all.name == "Corn"
    #     stuff_all.color_code = "#ffff80"
    #   end
    #
    #   if stuff_all.name == "White"
    #     stuff_all.color_code = "#fffef2"
    #   end
    #   stuff_all.save
    # end

    stuff_type = StuffType.where({name:"POCKET"}).first
    stuffAll = StuffColor.where({color_layer:0}).where({stuff_type:stuff_type})
    stuffType_botton = StuffType.where({name:"HALF_MOON"}).first
    stuffAll.each_with_index do |color,index|
      newColor = StuffColor.new
      newColor.name = color.name
      newColor.color_layer = 0
      newColor.color_price = color.color_price
      newColor.color_code = color.color_code
      newColor.priority = index+1
      newColor.stuff_type = stuffType_botton
      newColor.save
    end
    stuffAll.each_with_index do |color,index|
      newColor = StuffColor.new
      newColor.name = color.name
      newColor.color_layer = 1
      newColor.color_price = color.color_price
      newColor.color_code = color.color_code
      newColor.priority = index+1
      newColor.stuff_type = stuffType_botton
      newColor.save
    end
    stuffAll.each_with_index do |color,index|
      newColor = StuffColor.new
      newColor.name = color.name
      newColor.color_layer = 2
      newColor.color_price = color.color_price
      newColor.color_code = color.color_code
      newColor.priority = index+1
      newColor.stuff_type = stuffType_botton
      newColor.save
    end

    stuff_Type = StuffType.where({name:"WRIST"}).first
    Stuff.where({stuff_type:stuff_Type,belong_to_type:80}).each do |stuff|
      newStuff = Stuff.new
      newStuff.name = stuff.name+"_T"
      newStuff.desc = stuff.desc+"_T"
      newStuff.belong_to_type = 81
      newStuff.price = stuff.price
      newStuff.additional_price = stuff.additional_price
      newStuff.color_ratio_0 = stuff.color_ratio_0
      newStuff.color_ratio_1 = stuff.color_ratio_1
      newStuff.stuff_type = stuff.stuff_type
    
      newStuff.stuff_img = stuff.stuff_img
      newStuff.stuff_product = stuff.stuff_product
      newStuff.stuff_product_img_two = stuff.stuff_product_img_two
      newStuff.stuff_product_img_three = stuff.stuff_product_img_three
      newStuff.priority = stuff.priority
      newStuff.save
    end

  end

  def custom_img

    stuff_type = StuffType.where({name:"BODY"}).first
    stuff_polo = Stuff.where({stuff_type:stuff_type,belong_to_type:"80"})
    stuff_t = Stuff.where({stuff_type:stuff_type,belong_to_type:"81"})

    stuff_polo.each do |stuff|
      puts "stuff #{stuff.name}"
      stuff.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
      stuff.save
    end

    stuff_t.each do |stuff|
      stuff.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-type_tshirt.png").open
      stuff.save
    end

    redirect_to root_path

    # body_9 = Stuff.new
    # body_9.name = "BODY_9"
    # body_9.desc = "BODY_9"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "80"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_9.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_9.png").open
    # # body_9.stuff_product_img_three = Rails.root.join("ipolo_stuff/processed/Artboard-9-base.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_10"
    # body_9.desc = "BODY_10"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "80"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_10.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_10.png").open
    # body_9.stuff_product_img_three = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_10_2.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_11"
    # body_9.desc = "BODY_11"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "80"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_11.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_11.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_12"
    # body_9.desc = "BODY_12"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "80"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_12.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_12.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_13"
    # body_9.desc = "BODY_13"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "80"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_13.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_13.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_14"
    # body_9.desc = "BODY_14"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "80"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_14.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_14.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_15"
    # body_9.desc = "BODY_15"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "80"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_15.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_15.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_16"
    # body_9.desc = "BODY_16"
    # body_9.belong_to_type = "80"
    # body_9.stuff_type = stuff_type
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_16.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_16.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_17"
    # body_9.desc = "BODY_17"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "80"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_17.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_17.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_18"
    # body_9.desc = "BODY_18"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "80"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_18.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_18.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_19"
    # body_9.desc = "BODY_19"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "80"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_19.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_19.png").open
    # body_9.stuff_product_img_three = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_19_2.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_20"
    # body_9.desc = "BODY_20"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "80"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_20.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_20.png").open
    # body_9.save
    
    
    # ###############################################################################################################
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_9_T"
    # body_9.desc = "BODY_9_T"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "81"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_9.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_9.png").open
    # # body_9.stuff_product_img_three = Rails.root.join("ipolo_stuff/processed/Artboard-9-base.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_10_T"
    # body_9.desc = "BODY_10_T"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "81"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_10.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_10.png").open
    # body_9.stuff_product_img_three = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_10_2.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_11_T"
    # body_9.desc = "BODY_11_T"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "81"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_11.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_11.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_12_T"
    # body_9.desc = "BODY_12_T"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "81"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_12.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_12.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_13_T"
    # body_9.desc = "BODY_13_T"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "81"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_13.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_13.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_14_T"
    # body_9.desc = "BODY_14_T"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "81"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_14.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_14.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_15_T"
    # body_9.desc = "BODY_15_T"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "81"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_15.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_15.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_16_T"
    # body_9.desc = "BODY_16_T"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "81"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_16.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_16.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_17_T"
    # body_9.desc = "BODY_17_T"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "81"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_17.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_17.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_18_T"
    # body_9.desc = "BODY_18_T"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "81"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_18.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_18.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_19_T"
    # body_9.desc = "BODY_19_T"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "81"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_19.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_19.png").open
    # body_9.stuff_product_img_three = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_19_2.png").open
    # body_9.save
    
    # body_9 = Stuff.new
    # body_9.name = "BODY_20_T"
    # body_9.desc = "BODY_20_T"
    # body_9.stuff_type = stuff_type
    # body_9.belong_to_type = "81"
    # body_9.stuff_img = Rails.root.join("ipolo_stuff/icon/Artboard-10-base_20.png").open
    # body_9.stuff_product_img = Rails.root.join("ipolo_stuff/processed/Artboard-1-base.png").open
    # body_9.stuff_product_img_two = Rails.root.join("ipolo_stuff/processed/Artboard-1-base_20.png").open
    # body_9.save

  end

end
