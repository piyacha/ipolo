class AddContactToStuffExist < ActiveRecord::Migration
  def change
    add_column :stuff_exists, :contact, :boolean, default: true
  end
end
