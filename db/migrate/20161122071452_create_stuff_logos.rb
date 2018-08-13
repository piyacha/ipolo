class CreateStuffLogos < ActiveRecord::Migration
  def change
    create_table :stuff_logos do |t|

      t.timestamps null: false
    end
  end
end
