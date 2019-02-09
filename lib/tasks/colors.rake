namespace :colors do
  desc "TODO"
  # bundle exec rake colors:import
  task import: :environment do
    p "START COLORS IMPORT"
    colors = [
      {:name => "White",:code => "#FFFFFF",:price => 10.0},
      {:name => nil,:code => "#FFFFF0",:price => 10.0},
      {:name => nil,:code => "#FFFACD",:price => 10.0},
      {:name => nil,:code => "#FFFF66",:price => 10.0},
      {:name => nil,:code => "#FFCC66",:price => 10.0},
      {:name => nil,:code => "#FFCC00",:price => 10.0},
      {:name => nil,:code => "#FFA500",:price => 10.0},
      {:name => nil,:code => "#FFA07A",:price => 10.0},
      {:name => nil,:code => "#FF8C00",:price => 10.0},
      {:name => nil,:code => "#FF6600",:price => 10.0},
      {:name => nil,:code => "#CD3700",:price => 10.0},
      {:name => nil,:code => "#aa480b",:price => 10.0},
      {:name => nil,:code => "#EE6363",:price => 10.0},
      {:name => nil,:code => "#CD5555",:price => 10.0},
      {:name => nil,:code => "#FFFAFA",:price => 10.0},
      {:name => nil,:code => "#F8F8FF",:price => 10.0},
      {:name => nil,:code => "#FFC0CB",:price => 10.0},
      {:name => nil,:code => "#FFB6C1",:price => 10.0}, 
      {:name => nil,:code => "#FF69B4",:price => 10.0},
      {:name => nil,:code => "#B03060",:price => 10.0},
      {:name => nil,:code => "#87CEFA",:price => 10.0},
      {:name => nil,:code => "#99CCFF",:price => 10.0},
      {:name => nil,:code => "#4F94CD",:price => 10.0},
      {:name => nil,:code => "#4682B4",:price => 10.0},
      {:name => nil,:code => "#333399",:price => 10.0},
      {:name => nil,:code => "#27408B",:price => 10.0},
      {:name => nil,:code => "#99FFFF",:price => 10.0},
      {:name => nil,:code => "#33CCFF",:price => 10.0},
      {:name => nil,:code => "#0099CC",:price => 10.0},
      {:name => nil,:code => "#006699",:price => 10.0},
      {:name => nil,:code => "#CCCCFF",:price => 10.0},
      {:name => nil,:code => "#bb7bd1",:price => 10.0},
      {:name => nil,:code => "#6f4696",:price => 10.0},
      {:name => nil,:code => "#660099",:price => 10.0},
      {:name => nil,:code => "#62dbb7",:price => 10.0},
      {:name => nil,:code => "#F0FFF0",:price => 10.0},
      {:name => nil,:code => "#CCFF66",:price => 10.0},
      {:name => nil,:code => "#9ACD32",:price => 10.0},
      {:name => nil,:code => "#00CD66",:price => 10.0},
      {:name => nil,:code => "#2E8B57",:price => 10.0},
      {:name => nil,:code => "#2b3a0c",:price => 10.0},
      {:name => nil,:code => "#526d1a",:price => 10.0},
      {:name => nil,:code => "#037f68",:price => 10.0},
      {:name => nil,:code => "#083024",:price => 10.0},
      {:name => nil,:code => "#CD00CD",:price => 10.0},
      {:name => nil,:code => "#EED5B7",:price => 10.0},
      {:name => nil,:code => "#EED8AE",:price => 10.0},
      {:name => nil,:code => "#8B7355",:price => 10.0},
      {:name => nil,:code => "#684321",:price => 10.0},
      {:name => nil,:code => "#8B4513",:price => 10.0},
      {:name => nil,:code => "#301b08",:price => 10.0},
      {:name => nil,:code => "#548B54",:price => 10.0},
      {:name => nil,:code => "#000000",:price => 10.0},
      {:name => nil,:code => "#B22222",:price => 10.0},
      {:name => nil,:code => "#A52A2A",:price => 10.0},
      {:name => nil,:code => "#8B0000",:price => 10.0},
      {:name => nil,:code => "#470921",:price => 10.0},
      {:name => nil,:code => "#3d0017",:price => 10.0},
      {:name => nil,:code => "#350014",:price => 10.0},
      {:name => nil,:code => "#D3D3D3",:price => 10.0},
      {:name => nil,:code => "#BEBEBE",:price => 10.0},
      {:name => nil,:code => "#8B8989",:price => 10.0},
      {:name => nil,:code => "#36648B",:price => 10.0},
      {:name => nil,:code => "#09092b",:price => 10.0},
      {:name => nil,:code => "#070721",:price => 10.0}
    ]
    StuffColor.all().destroy_all
    stuff_types = StuffType.where(active: true).where.not(name: "TYPE")
    [0,1,2].each do |count|
      colors.each_with_index do |color, index|
        stuff_types.each do |stuff_type|
          p "======== color[:code] #{color[:code]}"
          color_new = StuffColor.new
          name = color[:name]
          name ||= "color_#{index}_#{color[:code]}"
          color_new.name = name
          color_new.color_code = color[:code]
          color_new.color_price = color[:price]
          color_new.color_layer = count
          color_new.stuff_type = stuff_type
          color_new.save
        end
      end
    end
  end

end
