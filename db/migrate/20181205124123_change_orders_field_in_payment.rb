class ChangeOrdersFieldInPayment < ActiveRecord::Migration
  def change
    remove_column :payments, :orders_id
    add_reference :payments, :order, index: true
  end
end
