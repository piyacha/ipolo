class AddPriceAfterCreditAndPledge < ActiveRecord::Migration
  def change
    add_column :quotations, :final_price, :float, default: 0
  end
end
