class Credit < ActiveRecord::Base

  def self.enable_access_control
    true
  end

  def name
    self.custom_name
  end

end
