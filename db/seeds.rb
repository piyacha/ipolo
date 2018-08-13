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



