class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :users, index: true
      t.belongs_to :orders, index: true
      t.string :name, null: false, default: ""
      t.float :paid_amount, default: 0
      t.datetime :paid_at
      t.timestamps null: false
    end
  end
end
