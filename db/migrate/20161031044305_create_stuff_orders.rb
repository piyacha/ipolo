class CreateStuffOrders < ActiveRecord::Migration
  def change
    create_table :stuff_orders do |t|
      t.belongs_to :stuff, index: true
      t.belongs_to :order, index: true
      t.timestamps null: false
    end
  end
end
