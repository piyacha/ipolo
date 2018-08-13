class AddColorRatioToStuff < ActiveRecord::Migration
  def change
    add_column :stuffs, :color_ratio_0, :float, default: 1
    add_column :stuffs, :color_ratio_1, :float, default: 1
  end
end
