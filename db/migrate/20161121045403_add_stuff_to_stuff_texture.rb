class AddStuffToStuffTexture < ActiveRecord::Migration
  def change
    add_reference :stuff_textures, :stuffs, index: true
    remove_column :stuff_textures, :stuff_types_id
  end
end
