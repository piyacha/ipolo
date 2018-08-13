class CreateStuffTextures < ActiveRecord::Migration
  def change
    create_table :stuff_textures do |t|
      t.belongs_to :stuff_types, index: true
      t.string :name, null: false, default: ""
      t.integer :priority, default: 0
      t.timestamps null: false
    end
  end
end
