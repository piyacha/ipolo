class StuffTexture < ActiveRecord::Base

  belongs_to :stuff

  has_attached_file :stuff_texture_img,
                    :url => "/:attachment/:id_partition/:style/:basename.:extension",
                    :path => ":rails_root/public/:attachment/:id_partition/:style/:basename.:extension",
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "https://image.freepik.com/free-icon/error-404_318-117678.png"
  validates_attachment_content_type :stuff_texture_img, content_type: /\Aimage\/.*\z/

  def self.enable_access_control
    true
  end

end
