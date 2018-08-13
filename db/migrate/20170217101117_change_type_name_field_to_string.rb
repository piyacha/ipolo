class ChangeTypeNameFieldToString < ActiveRecord::Migration
  def change
    remove_column :quotation_prices, :name
    add_column :quotation_prices, :name, :string, default: ""
  end
end
