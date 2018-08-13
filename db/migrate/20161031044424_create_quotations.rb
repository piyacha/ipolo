class CreateQuotations < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.belongs_to :order, index: true
      t.timestamps null: false
    end
  end
end
