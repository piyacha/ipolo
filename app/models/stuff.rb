class Stuff < ActiveRecord::Base
  belongs_to :stuff_type
  has_many :stuff_colors
  accepts_nested_attributes_for :stuff_colors, allow_destroy: true

  has_attached_file :stuff_img,
                    :url => "/:attachment/:id_partition/:style/:basename.:extension",
                    :path => ":rails_root/public/:attachment/:id_partition/:style/:basename.:extension",
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "https://image.freepik.com/free-icon/error-404_318-117678.png"
  validates_attachment_content_type :stuff_img, content_type: /\Aimage\/.*\z/
  # attr_accessor :delete_stuff_img
  # before_validation { stuff_img.clear if delete_stuff_img == '1' }

  has_attached_file :stuff_product_img,
                    :url => "/:attachment/:id_partition/:style/:basename.:extension",
                    :path => ":rails_root/public/:attachment/:id_partition/:style/:basename.:extension",
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: ""
  validates_attachment_content_type :stuff_product_img, content_type: /\Aimage\/.*\z/

  has_attached_file :stuff_product_img_two,
                    :url => "/:attachment/:id_partition/:style/:basename.:extension",
                    :path => ":rails_root/public/:attachment/:id_partition/:style/:basename.:extension",
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: ""
  validates_attachment_content_type :stuff_product_img_two, content_type: /\Aimage\/.*\z/

  has_attached_file :stuff_product_img_three,
                    :url => "/:attachment/:id_partition/:style/:basename.:extension",
                    :path => ":rails_root/public/:attachment/:id_partition/:style/:basename.:extension",
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: ""
  validates_attachment_content_type :stuff_product_img_three, content_type: /\Aimage\/.*\z/

  attr_writer :remove_stuff_img
  def remove_stuff_img
    @remove_stuff_img || false
  end
  attr_writer :remove_stuff_product_img
  def remove_stuff_product_img
    @remove_stuff_product_img || false
  end
  attr_writer :remove_stuff_product_img_two
  def remove_stuff_product_img_two
    @remove_stuff_product_img_two || false
  end
  attr_writer :remove_stuff_product_img_three
  def remove_stuff_product_img_three
    @remove_stuff_product_img_three || false
  end

  before_validation {
    self.stuff_img.clear if self.remove_stuff_img == '1'
    self.stuff_product_img.clear if self.remove_stuff_product_img == '1'
    self.stuff_product_img_two.clear if self.remove_stuff_product_img_two == '1'
    self.stuff_product_img_three.clear if self.remove_stuff_product_img_three == '1'
  }


  def self.enable_access_control
    true
  end

end
