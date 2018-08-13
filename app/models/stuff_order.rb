class StuffOrder < ActiveRecord::Base

  belongs_to :stuff
  belongs_to :order

  def self.enable_access_control
    true
  end
end
