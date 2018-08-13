class AddStuffResetToStuff < ActiveRecord::Migration
  def change
    add_column :stuffs, :delete_stuff_button, :boolean, default: true
  end
end
