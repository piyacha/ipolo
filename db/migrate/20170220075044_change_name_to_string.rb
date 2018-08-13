class ChangeNameToString < ActiveRecord::Migration
  def change
    remove_column :pledges, :name
    add_column :pledges, :name, :string, default: ""
    remove_column :credits, :name
    add_column :credits, :name, :string, default: ""
  end
end
