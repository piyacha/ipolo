class RemoveRelationToQuotationPriceAndStuffExistedSize < ActiveRecord::Migration
  def change
    remove_column :quotation_prices, :quotations
    remove_column :stuff_exist_sizes, :stuff_exists
  end
end
