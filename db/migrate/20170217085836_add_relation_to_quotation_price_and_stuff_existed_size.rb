class AddRelationToQuotationPriceAndStuffExistedSize < ActiveRecord::Migration
  def change
    add_reference :quotation_prices, :quotations, index: true
    add_reference :stuff_exist_sizes, :stuff_exists, index: true
  end
end
