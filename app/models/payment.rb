class Payment < ActiveRecord::Base

  belongs_to :user
  belongs_to :order
  belongs_to :bank_account

  has_attached_file :image,
                    :url => "/:attachment/:id_partition/:style/:basename.:extension",
                    :path => ":rails_root/public/:attachment/:id_partition/:style/:basename.:extension",
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "https://image.freepik.com/free-icon/error-404_318-117678.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  def self.enable_access_control
    true
  end

  attr_writer :remove_image
  def remove_image
    @remove_image || false
  end
  before_validation {
    self.image.clear if self.remove_image == '1'
  }
end
