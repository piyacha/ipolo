class CreateStuffTypes < ActiveRecord::Migration
  def change
    create_table :stuff_types do |t|
      t.string :name, null: false, default: ""
      t.string :desc, default: ""
      t.timestamps null: false
    end
  end
end
