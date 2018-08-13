class Quotation < ActiveRecord::Base

  include Rails.application.routes.url_helpers

  belongs_to :admin_user
  belongs_to :pledge
  belongs_to :credit

  has_many :quotation_prices
  accepts_nested_attributes_for :quotation_prices, :allow_destroy => true

  has_attached_file :stuff_img,
                    :url => "/:attachment/:id_partition/:style/:basename.:extension",
                    :path => ":rails_root/public/:attachment/:id_partition/:style/:basename.:extension",
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: ""
  validates_attachment_content_type :stuff_img, content_type: /\Aimage\/.*\z/

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

  def self.quotation_report(id)
    @quotation = nil
    quotation = Quotation.find(id)
    if !quotation.nil?
      @quotation_price = QuotationPrice.where({quotation:quotation})
      @quotation_detail = quotation
    end
    @total = 0
    @total_vat = 0
    # @quotation_price.each do |price|
    #   @total = @total + (price.price * price.amount)
    # end
    @total = quotation.final_price.ceil

    # profit = (JSON.parse(quotation.price_amount_report))['profit'].to_f
    # @total = @total * profit

    @total_vat = ( (@total*7)/100 )

    price = []
    total_amount = 0
    @quotation_price.each_with_index do |quotation,index|
      price.push({
          index:index,
          name:quotation.name,
          amount:quotation.amount,
          price:quotation.price
                 })
      total_amount = total_amount + quotation.amount.to_i
    end

    stuff_details = []
    JSON.parse(quotation.stuff_picker).each do |stuff|
      if stuff['stuff_type_name'] == 'TYPE'
        stuff_details.push({
            stuff_type_name:'TYPE',
            stuff_name:stuff['stuff_name'],
            texture_name:stuff['texture_name'],
            desc:stuff['desc'],
            texture_desc:stuff['texture_desc'],
                           })
      else
        stuff_details.push({
           stuff_type_name:stuff['stuff_type_name'],
           desc:stuff['desc'],
           stuff_name:stuff['stuff_name'],
        })
      end

    end

    stuff_image = ""
    if @quotation_detail.stuff_img
      stuff_image = @quotation_detail.stuff_img.url();
    end

    return {
        total:@total,
        total_vat:@total_vat,
        quotation_price:price,
        total_amount:total_amount,
        stuff_details:stuff_details,
        first_name:@quotation_detail.first_name,
        address:@quotation_detail.address,
        stuff_image:stuff_image,
        company_name:@quotation_detail.company_name,
        admin_username:@quotation_detail.admin_user.username,
        updated_at:@quotation_detail.updated_at.strftime("%d / %m / %Y"),
        tel:@quotation_detail.tel,
        fax:@quotation_detail.fax,
        credit_name:@quotation_detail.credit.name,
        pledge_name:@quotation_detail.pledge.name,
        email:@quotation_detail.email,
        estimate_cost:@quotation_detail.estimate_cost,
        stuff_picker:@quotation_detail.stuff_picker
    }

  end

end
