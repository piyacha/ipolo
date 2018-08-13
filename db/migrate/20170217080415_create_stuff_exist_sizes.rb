class CreateStuffExistSizes < ActiveRecord::Migration
  def change
    create_table :stuff_exist_sizes do |t|
      t.integer :name, default: ""
      t.integer :sex, default: ""
      t.integer :priority, default: 0
      t.float :price, default: 0
      t.timestamps null: false
    end
  end
end
