class CreateStaticValues < ActiveRecord::Migration
  def change
    create_table :static_values do |t|

      t.string :key
      t.string :value
      
      t.boolean :active, null: false, default: true
      t.timestamps null: false
    end
  end
end
