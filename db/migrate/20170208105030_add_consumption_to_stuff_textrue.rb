class AddConsumptionToStuffTextrue < ActiveRecord::Migration
  def change
    remove_column :stuff_types, :consumption
    add_column :stuff_textures, :consumption, :float , default: 0
  end
end
