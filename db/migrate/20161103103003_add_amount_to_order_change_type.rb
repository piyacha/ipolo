class AddAmountToOrderChangeType < ActiveRecord::Migration
  def change
    remove_column :orders, :amount
    add_column :orders, :amount, :string, null: true, default: ""
  end
end
