class AddGroupRoleAndAdminUserToSettingRole < ActiveRecord::Migration
  def change

    add_reference :setting_roles, :group_role, index: true
    add_reference :setting_roles, :admin_user, index: true

  end
end
