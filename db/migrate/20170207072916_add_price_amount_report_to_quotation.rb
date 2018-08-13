class AddPriceAmountReportToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :price_amount_report, :string, default: ""
  end
end
