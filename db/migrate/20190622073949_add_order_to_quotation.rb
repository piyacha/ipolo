class AddOrderToQuotation < ActiveRecord::Migration
  def change
    add_reference :quotations, :order, index: true
  end
end
