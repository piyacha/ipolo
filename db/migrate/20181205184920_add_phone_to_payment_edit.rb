class AddPhoneToPaymentEdit < ActiveRecord::Migration
  def change
    add_column :payments, :phone, :string, default: ""
    remove_column :bank_accounts, :phone
  end
end
