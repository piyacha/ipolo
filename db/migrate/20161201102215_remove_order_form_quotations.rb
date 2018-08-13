class RemoveOrderFormQuotations < ActiveRecord::Migration
  def change
    remove_column :quotations, :order_id
  end
end
