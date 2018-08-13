class AddChangeTypeEstimateCostToOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :estimate_cost
    add_column :orders, :estimate_cost, :string, default: ""
  end
end
