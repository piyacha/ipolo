class AddPriorityToStuffType < ActiveRecord::Migration
  def change
    add_column :stuff_types, :priority, :integer, null: true, default: 0
  end
end
