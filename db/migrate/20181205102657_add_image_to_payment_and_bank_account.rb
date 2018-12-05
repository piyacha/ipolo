class AddImageToPaymentAndBankAccount < ActiveRecord::Migration
  def change
    add_attachment :payments, :image
    add_attachment :bank_accounts, :image

    add_reference :payments, :bank_account, index: true
  end
end
