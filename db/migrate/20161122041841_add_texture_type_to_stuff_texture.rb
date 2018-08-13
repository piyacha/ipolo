class AddTextureTypeToStuffTexture < ActiveRecord::Migration
  def change
    add_column :stuff_textures, :status_flexible, :float, default: 5
    add_column :stuff_textures, :status_thick, :float, default: 5
    add_column :stuff_textures, :status_velvety, :float, default: 5
  end
end
