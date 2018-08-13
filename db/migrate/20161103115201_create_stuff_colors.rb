class CreateStuffColors < ActiveRecord::Migration
  def change
    create_table :stuff_colors do |t|
      t.string :name
      t.string :color_code
      t.boolean :active, null: false, default: true
      t.integer :priority, default: 0
      t.timestamps null: false
    end
  end
end
