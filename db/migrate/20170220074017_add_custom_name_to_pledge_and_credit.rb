class AddCustomNameToPledgeAndCredit < ActiveRecord::Migration
  def change
    add_column :pledges, :custom_name, :string, default: ""
    add_column :credits, :custom_name, :string, default: ""
  end
end
