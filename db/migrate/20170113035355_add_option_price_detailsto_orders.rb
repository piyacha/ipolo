class AddOptionPriceDetailstoOrders < ActiveRecord::Migration
  def change
    add_column :orders, :option_price_details, :string, default: ""
    add_column :quotations, :option_price_details, :string, default: ""
  end
end
