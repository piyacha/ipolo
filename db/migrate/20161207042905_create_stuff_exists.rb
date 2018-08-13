class CreateStuffExists < ActiveRecord::Migration
  def change
    create_table :stuff_exists do |t|

      t.string :name
      t.string :desc
      t.string :size

      # t.float :total_price
      t.boolean :active, null: false, default: true
      t.timestamps null: false
    end
  end
end
