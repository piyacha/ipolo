class AddBranchBankNameToBankAccount < ActiveRecord::Migration
  def change
    add_column :bank_accounts, :branch, :string, default: ""
    add_column :bank_accounts, :bank_name, :string, default: ""
  end
end
