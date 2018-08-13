class AddColorRatioThreeToStuff < ActiveRecord::Migration
  def change
    add_column :stuffs, :color_ratio_2, :float, default: 1
  end
end
