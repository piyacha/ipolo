class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :tel
      t.string :email
      t.string :note

      t.float :total_price
      t.boolean :active, null: false, default: true
      t.timestamps null: false

    end
  end
end
