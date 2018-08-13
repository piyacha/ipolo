class AddBasePriceToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :base_price, :string, default: ""
  end
end
