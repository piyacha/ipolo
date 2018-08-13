class StuffExist < ActiveRecord::Base

  has_many :stuff_exist_size
  accepts_nested_attributes_for :stuff_exist_size, :allow_destroy => true

  has_attached_file :stuff_exist_img,
                    :url => "/:attachment/:id_partition/:style/:basename.:extension",
                    :path => ":rails_root/public/:attachment/:id_partition/:style/:basename.:extension",
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "https://image.freepik.com/free-icon/error-404_318-117678.png"
  validates_attachment_content_type :stuff_exist_img, content_type: /\Aimage\/.*\z/
  def self.enable_access_control
    true
  end

  attr_writer :remove_stuff_exist_img
  def remove_stuff_exist_img
    @remove_stuff_exist_img || false
  end
  before_validation {
    self.stuff_exist_img.clear if self.remove_stuff_exist_img == '1'
  }

end
