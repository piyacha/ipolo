class AddPriceAmountReportToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :price_amount_report, :string, default: ""
  end
end
