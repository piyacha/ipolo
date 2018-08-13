class AddPriorityToStuffSize < ActiveRecord::Migration
  def change
    add_column :stuff_sizes, :priority, :integer, null: true, default: 0
  end
end
