class AddDescToStuffTexture < ActiveRecord::Migration
  def change
    add_column :stuff_textures, :desc, :string, default: ""
  end
end
