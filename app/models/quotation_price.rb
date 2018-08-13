class QuotationPrice < ActiveRecord::Base

  belongs_to :quotation

  def self.enable_access_control
    true
  end

end
