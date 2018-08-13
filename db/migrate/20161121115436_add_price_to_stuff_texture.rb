class AddPriceToStuffTexture < ActiveRecord::Migration
  def change
    add_column :stuff_textures, :price, :float, default: 1
  end
end
