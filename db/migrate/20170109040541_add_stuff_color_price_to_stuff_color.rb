class AddStuffColorPriceToStuffColor < ActiveRecord::Migration
  def change
    add_column :stuff_colors, :color_price, :float, default: 1
  end
end
