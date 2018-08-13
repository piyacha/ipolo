class AddActiveToStuffType < ActiveRecord::Migration
  def change
    add_column :stuff_types, :active, :boolean, null: true, default: true
  end
end
