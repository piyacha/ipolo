class AddfieldToOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :amount
    remove_column :orders, :total_price

    add_attachment :orders, :stuff_img

    add_column :orders, :estimate_cost, :float, default: 0
    add_column :orders, :stuff_picker, :string, default: ""
    add_column :orders, :stuff_price, :string, default: ""

  end
end
