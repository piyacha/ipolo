class AddActiveToStuffTexture < ActiveRecord::Migration
  def change
    add_attachment :stuff_textures, :stuff_texture_img
    add_column :stuff_textures, :active, :boolean, null: true, default: true
  end
end
