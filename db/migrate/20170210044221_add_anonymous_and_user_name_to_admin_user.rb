class AddAnonymousAndUserNameToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :username, :string, null: false, default: ""
    add_column :admin_users, :anonymous, :boolean, default: false
  end
end
