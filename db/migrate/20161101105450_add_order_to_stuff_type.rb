class AddOrderToStuffType < ActiveRecord::Migration
  def change
    add_column :stuff_types, :order, :integer, null: true, default: 0
  end
end
