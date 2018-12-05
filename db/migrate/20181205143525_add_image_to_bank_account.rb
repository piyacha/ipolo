class AddImageToBankAccount < ActiveRecord::Migration
  def change
    add_column :bank_accounts, :slug, :string, default: ""
  end
end
