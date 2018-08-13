class StuffExistSize < ActiveRecord::Base

  belongs_to :stuff_exist

  def self.enable_access_control
    true
  end

end
