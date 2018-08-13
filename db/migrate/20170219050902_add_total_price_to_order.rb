class AddTotalPriceToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :total_price, :float , default: 0
    add_column :quotations, :total_price, :float , default: 0
  end
end
