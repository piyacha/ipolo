class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.string :no, null: false, default: ""
      t.string :name, null: false, default: ""

      t.boolean :active, null: false, default: true
      t.timestamps null: false
    end
  end
end
