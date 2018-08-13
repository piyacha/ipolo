class AddStuffResetToStuffType < ActiveRecord::Migration
  def change
    add_column :stuff_types, :delete_stuff_button, :boolean, default: true
  end
end
