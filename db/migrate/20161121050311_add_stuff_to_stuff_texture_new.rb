class AddStuffToStuffTextureNew < ActiveRecord::Migration
  def change
    remove_column :stuff_textures, :stuff_id
    add_reference :stuff_textures, :stuff, index: true
  end
end
