class AddAmountToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :amount, :integer, null: true, default: 0
  end
end
