# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

# StuffType.create!(name: 'TYPE', priority: 0, active: true)
# StuffType.create!(name: 'BODY', priority: 1, active: true)
# StuffType.create!(name: 'NECK', priority: 2, active: true)
# StuffType.create!(name: 'ARM', priority: 3, active: true)
# StuffType.create!(name: 'BOTTOM', priority: 4, active: true)
# StuffType.create!(name: 'LOGO', priority: 5, active: true)
#
# type_stuffType = StuffType.where({:name => "TYPE"}).first
# Stuff.create!(name: 'TYPE_seed', active: true, price:0, stuff_type_id:type_stuffType.id)
#
# body_stuffType = StuffType.where({:name => "BODY"}).first
# Stuff.create!(name: 'BODY_1_seed', active: true, price:0, stuff_type_id:body_stuffType.id)
# Stuff.create!(name: 'BODY_2_seed', active: true, price:0, stuff_type_id:body_stuffType.id)
# Stuff.create!(name: 'BODY_3_seed', active: true, price:0, stuff_type_id:body_stuffType.id)
# Stuff.create!(name: 'BODY_4_seed', active: true, price:0, stuff_type_id:body_stuffType.id)
#
# neck_stuffType = StuffType.where({:name => "NECK"}).first
# Stuff.create!(name: 'NECK_1_seed', active: true, price:0, stuff_type_id:neck_stuffType.id)
#
# arm_stuffType = StuffType.where({:name => "ARM"}).first
# Stuff.create!(name: 'ARM_1_seed', active: true, price:0, stuff_type_id:arm_stuffType.id)
#
# size_stuffType = Stuff.where({:name => "TYPE_seed"}).first
# StuffSize.create!(stuff_id: size_stuffType.id,name:"3XL",  priority:0, active:true)
# StuffSize.create!(stuff_id: size_stuffType.id,name:"2XL",  priority:1, active:true)
# StuffSize.create!(stuff_id: size_stuffType.id,name:"XL",  priority:2, active:true)
# StuffSize.create!(stuff_id: size_stuffType.id,name:"L",  priority:3, active:true)
# StuffSize.create!(stuff_id: size_stuffType.id,name:"M",  priority:4, active:true)
# StuffSize.create!(stuff_id: size_stuffType.id,name:"S",  priority:5, active:true)
#
# arm_stuffType = StuffType.where({:name => "ARM"}).first
# StuffColor.create!(stuff_type_id: arm_stuffType.id, name:"red",  priority:0, active:true, color_code:"#FF0000")
# StuffColor.create!(stuff_type_id: arm_stuffType.id, name:"green",  priority:0, active:true, color_code:"#00FF00")
# StuffColor.create!(stuff_type_id: arm_stuffType.id, name:"blue",  priority:0, active:true, color_code:"#0000FF")
# StuffColor.create!(stuff_type_id: arm_stuffType.id, name:"megenta",  priority:0, active:true, color_code:"#FF00FF")
# StuffColor.create!(stuff_type_id: arm_stuffType.id, name:"orange",  priority:0, active:true, color_code:"#FF8000")
#
# neck_stuffType = StuffType.where({:name => "NECK"}).first
# StuffColor.create!(stuff_type_id: neck_stuffType.id, name:"red",  priority:0, active:true, color_code:"#FF0000")
# StuffColor.create!(stuff_type_id: neck_stuffType.id, name:"green",  priority:0, active:true, color_code:"#00FF00")
# StuffColor.create!(stuff_type_id: neck_stuffType.id, name:"blue",  priority:0, active:true, color_code:"#0000FF")
# StuffColor.create!(stuff_type_id: neck_stuffType.id, name:"megenta",  priority:0, active:true, color_code:"#FF00FF")
# StuffColor.create!(stuff_type_id: neck_stuffType.id, name:"orange",  priority:0, active:true, color_code:"#FF8000")
#
# body_stuffType = StuffType.where({:name => "BODY"}).first
# StuffColor.create!(stuff_type_id: body_stuffType.id, name:"red",  priority:0, active:true, color_code:"#FF0000")
# StuffColor.create!(stuff_type_id: body_stuffType.id, name:"green",  priority:0, active:true, color_code:"#00FF00")
# StuffColor.create!(stuff_type_id: body_stuffType.id, name:"blue",  priority:0, active:true, color_code:"#0000FF")
# StuffColor.create!(stuff_type_id: body_stuffType.id, name:"megenta",  priority:0, active:true, color_code:"#FF00FF")
# StuffColor.create!(stuff_type_id: body_stuffType.id, name:"orange",  priority:0, active:true, color_code:"#FF8000")
#
# Order.create!(first_name: "test_first_name", last_name:"test_last_name", active:true)


# GroupRole.create!(name:"superadmin")
# AdminUser.create!(email: 'iderative@example.com', password: 'password', password_confirmation: 'password')
# admin_user = AdminUser.where({:email => "iderative@example.com"}).first
# group_role = GroupRole.where({:name => "superadmin"}).first
# admin_user.group_role = group_role
# admin_user.save

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

    # stuff_type = StuffType.where({name:"POCKET"}).first
    # stuffAll = StuffColor.where({color_layer:0}).where({stuff_type:stuff_type})
    # stuffType_botton = StuffType.where({name:"HALF_MOON"}).first
    # stuffAll.each_with_index do |color,index|
    #   newColor = StuffColor.new
    #   newColor.name = color.name
    #   newColor.color_layer = 0
    #   newColor.color_price = color.color_price
    #   newColor.color_code = color.color_code
    #   newColor.priority = index+1
    #   newColor.stuff_type = stuffType_botton
    #   newColor.save
    # end
    # stuffAll.each_with_index do |color,index|
    #   newColor = StuffColor.new
    #   newColor.name = color.name
    #   newColor.color_layer = 1
    #   newColor.color_price = color.color_price
    #   newColor.color_code = color.color_code
    #   newColor.priority = index+1
    #   newColor.stuff_type = stuffType_botton
    #   newColor.save
    # end
    # stuffAll.each_with_index do |color,index|
    #   newColor = StuffColor.new
    #   newColor.name = color.name
    #   newColor.color_layer = 2
    #   newColor.color_price = color.color_price
    #   newColor.color_code = color.color_code
    #   newColor.priority = index+1
    #   newColor.stuff_type = stuffType_botton
    #   newColor.save
    # end

    # stuff_Type = StuffType.where({name:"WRIST"}).first
    # Stuff.where({stuff_type:stuff_Type,belong_to_type:80}).each do |stuff|
    #   newStuff = Stuff.new
    #   newStuff.name = stuff.name+"_T"
    #   newStuff.desc = stuff.desc+"_T"
    #   newStuff.belong_to_type = 81
    #   newStuff.price = stuff.price
    #   newStuff.additional_price = stuff.additional_price
    #   newStuff.color_ratio_0 = stuff.color_ratio_0
    #   newStuff.color_ratio_1 = stuff.color_ratio_1
    #   newStuff.stuff_type = stuff.stuff_type
    
    #   newStuff.stuff_img = stuff.stuff_img
    #   newStuff.stuff_product = stuff.stuff_product
    #   newStuff.stuff_product_img_two = stuff.stuff_product_img_two
    #   newStuff.stuff_product_img_three = stuff.stuff_product_img_three
    #   newStuff.priority = stuff.priority
    #   newStuff.save
    # end

    # stuff_type = StuffType.where({name:"BODY"}).first
    # stuff_polo = Stuff.where({stuff_type:stuff_type,belong_to_type:"80"})
    # stuff_t = Stuff.where({stuff_type:stuff_type,belong_to_type:"81"})

    # stuff_polo.each do |stuff|
    #   puts "stuff #{stuff.name}"
    #   stuff.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-base.png").open
    #   stuff.save
    # end
    # stuff_t.each do |stuff|
    #   stuff.stuff_product_img = Rails.root.join("ipolo_stuff/process/Artboard-1-type_tshirt.png").open
    #   stuff.save
    # end