class AddGroupRoleToAdminUser < ActiveRecord::Migration
  def change
    add_reference :admin_users, :group_role, index: true
  end
end
