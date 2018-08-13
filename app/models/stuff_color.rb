class StuffColor < ActiveRecord::Base

  belongs_to :stuff_type
  belongs_to :stuff

  before_save {
    if self.stuff_type == nil
      self.stuff_type = self.stuff.stuff_type
    end
  }

  def self.enable_access_control
    true
  end

end
