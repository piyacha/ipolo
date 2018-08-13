class AddColorLayerToStuffColor < ActiveRecord::Migration
  def change
    add_column :stuff_colors, :color_layer, :integer, default: 0
  end
end
