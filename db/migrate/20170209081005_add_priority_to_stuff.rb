class AddPriorityToStuff < ActiveRecord::Migration
  def change
    add_column :stuffs, :priority, :integer , default: 0
  end
end
