class AddConsumptionToStuffType < ActiveRecord::Migration
  def change
    add_column :stuff_types, :consumption, :float , default: 0
  end
end
