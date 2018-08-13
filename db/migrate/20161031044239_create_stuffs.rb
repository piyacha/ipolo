class CreateStuffs < ActiveRecord::Migration
  def change
    create_table :stuffs do |t|
      # t.string :account_no, null: false, default: ""
      # t.string :name, null: false, default: ""
      # t.string :encrypted_pin, null: false, default: ""
      # t.float :wallet_amount
      # t.timestamp :valid_date
      # t.timestamp :expire_date
      # t.boolean :locked, null: false, default: false
      # t.belongs_to :admin_user

      t.string :name, null: false, default: ""
      t.string :desc, default: ""
      t.float :price
      t.boolean :active, null: false, default: true

      t.timestamps null: false
    end
  end
end
