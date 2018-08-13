class AddAdminUserToOrderAndQuotation < ActiveRecord::Migration
  def change
    add_reference :orders, :admin_user, index: true
    add_reference :quotations, :admin_user, index: true
  end
end
