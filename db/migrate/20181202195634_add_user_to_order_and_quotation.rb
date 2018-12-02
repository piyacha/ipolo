class AddUserToOrderAndQuotation < ActiveRecord::Migration
  def change
    add_reference :orders, :user, index: true
    add_reference :quotations, :user, index: true
  end
end
