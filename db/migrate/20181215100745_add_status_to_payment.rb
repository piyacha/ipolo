class AddStatusToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :status, :string, default: "unpaid"
  end
end
