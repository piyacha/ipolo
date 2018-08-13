class SettingRole < ActiveRecord::Base

  belongs_to :group_role
  belongs_to :admin_user

  def self.enable_access_control
    true
  end

end
