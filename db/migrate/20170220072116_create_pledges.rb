class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.integer :name, default: ""
      t.float :value, default: 0
      t.integer :priority, default: 0
      t.boolean :active, null: false, default: true
      t.timestamps null: false
    end
  end
end
