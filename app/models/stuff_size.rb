class StuffSize < ActiveRecord::Base

  belongs_to :stuff

  def self.enable_access_control
    true
  end
end
