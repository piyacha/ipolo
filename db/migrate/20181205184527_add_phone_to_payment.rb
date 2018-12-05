class AddPhoneToPayment < ActiveRecord::Migration
  def change
    add_column :bank_accounts, :phone, :string, default: ""
  end
end
