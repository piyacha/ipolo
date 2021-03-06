class CreateLogoStaticValues < ActiveRecord::Migration
  def change
    create_table :logo_static_values do |t|
      t.string :name, default: ""
      t.string :logo_type, default: ""
      t.integer :amount, default: 0
      t.float :value, default: 0
      t.boolean :active, null: false, default: true
      t.timestamps null: false
    end
  end
  def up
    drop_table :logo_static_value
  end

end
