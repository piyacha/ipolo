class ChangeUserFieldInPayment < ActiveRecord::Migration
  def change
    remove_column :payments, :users_id
    add_reference :payments, :user, index: true
  end
end
