class AdminController < ApplicationController

  def order_make_quotation
    if params[:id]

      order = Order.find(params[:id])
      quotation = Quotation.new
      quotation.first_name     = order.first_name
      quotation.address        = order.address
      quotation.tel            = order.tel
      quotation.email          = order.email
      quotation.stuff_img      = order.stuff_img
      quotation.estimate_cost  = order.estimate_cost
      quotation.stuff_picker   = order.stuff_picker
      quotation.stuff_price    = order.stuff_price
      quotation.base_price     = order.base_price
      quotation.company_name   = order.company_name
      quotation.company_branch = order.company_branch
      quotation.price_amount_report = order.price_amount_report
      quotation.option_price_details = order.option_price_details
      quotation.tax_identification_number = order.tax_identification_number
      quotation.admin_user = order.admin_user
      quotation.total_price = order.total_price

      JSON.parse(order.estimate_cost).each do |size|
        if size['amount'] != ""
          quotation_price = QuotationPrice.new
          quotation_price.quotation = quotation
          quotation_price.name = size['size']
          quotation_price.amount = size['amount'].to_i
          quotation_price.price = size['price_per_unit'].to_f
          quotation_price.save
        end
      end

      if quotation.credit.nil?
        credit = Credit.order("priority DESC").first
        quotation.credit = credit
      else
        credit = quotation.credit
      end
      if quotation.pledge.nil?
        pledge = Pledge.order("priority DESC").first
        quotation.pledge = pledge
      else
        pledge = quotation.pledge
      end
      quotation.final_price = (quotation.total_price * credit.value * pledge.value).round(1)

      quotation.save
      order.status = "quotation"
      order.save
    end
    redirect_to admin_order_path(:id => params[:id])

  end

  def order_make_contact
    if params[:id]
      order = Order.find(params[:id])
      if order.status == "no contact"
        order.status = "contact"
        order.save
      end
    end
    redirect_to admin_order_path(:id => params[:id])
  end

end
