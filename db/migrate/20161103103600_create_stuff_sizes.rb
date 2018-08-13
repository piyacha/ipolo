class CreateStuffSizes < ActiveRecord::Migration
  def change
    create_table :stuff_sizes do |t|

      t.string :name
      t.string :desc
      t.boolean :active, null: false, default: true
      t.timestamps null: false
    end
  end
end
