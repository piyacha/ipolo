class AddNewRelationToQuotationPriceAndStuffExistedSize < ActiveRecord::Migration
  def change
    add_reference :quotation_prices, :quotation, index: true
    add_reference :stuff_exist_sizes, :stuff_exist, index: true
  end
end
