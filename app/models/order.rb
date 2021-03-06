class Order < ActiveRecord::Base

  has_many :quotations
  belongs_to :admin_user
  belongs_to :user

  has_attached_file :stuff_img,
                    :url => "/:attachment/:id_partition/:style/:basename.:extension",
                    :path => ":rails_root/public/:attachment/:id_partition/:style/:basename.:extension",
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: ""
  validates_attachment_content_type :stuff_img, content_type: /\Aimage\/.*\z/

  def order_name
    "#{self.first_name}"
  end

  def name
    "#{self.id}"
  end

  def json_price_amount_report
    if !self.price_amount_report.nil?
      return JSON.parse(self.price_amount_report)
    else
      return []
    end
  end

  def json_estimate_cost
    if !self.estimate_cost.nil?
      return JSON.parse(self.estimate_cost)
    else
      return []
    end
  end
  def self.enable_access_control
    true
  end

end