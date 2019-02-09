class IndexController < ApplicationController
  def index

  end

  def test

  end

  def price_calculate_doc
    if current_user
      send_file "#{Rails.root}/app/assets/pdf/price_calculate_doc.pdf", type: "application/pdf", x_sendfile: true
    end
  end
end
