class CreateQuotationPrices < ActiveRecord::Migration
  def change
    create_table :quotation_prices do |t|
      t.integer :name, default: ""
      t.integer :amount, default: 0
      t.float :price, default: 0
      t.timestamps null: false
    end
  end
end
