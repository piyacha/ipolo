class CreateStuffProfits < ActiveRecord::Migration
  def change
    create_table :stuff_profits do |t|
      t.string :name, default: ""
      t.integer :amount
      t.float :profit
      t.boolean :active, null: false, default: true
      t.timestamps null: false
    end
  end
end
