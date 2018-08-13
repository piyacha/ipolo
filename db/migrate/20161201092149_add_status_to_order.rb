class AddStatusToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :status, :string, default: "no contact"
  end
end
