class PrintController < ApplicationController

  def print_art_work

  end

  def print_order
    # render :layout => false
    if params[:from] == 'quotation'
      @order = Quotation.find(params[:id])
    elsif params[:from] == 'order'
      @order = Order.find(params[:id])
    end
    @size_male = []
    @size_female = []
    @total_amount_male = 0
    @total_amount_female = 0
    if @order
      JSON.parse(@order.base_price).each do |size|
        tmp_size = StuffSize.find(size['id'])
        if size['sex'] == 'male'
          if tmp_size
            JSON.parse(@order.estimate_cost).each do |est_mate|
              if (est_mate['size']).split("_")[0] == tmp_size.name and (est_mate['size']).split("_")[1] == tmp_size.sex
                @total_amount_male += est_mate['amount'].to_i
                @size_male.push({   name:tmp_size.name,
                                    breast:tmp_size.breast,
                                    long:tmp_size.long,
                                    amount:est_mate['amount'] })
              end
            end
          end
        elsif size['sex'] == 'female'
          JSON.parse(@order.estimate_cost).each do |est_mate|
            if (est_mate['size']).split("_")[0] == tmp_size.name and (est_mate['size']).split("_")[1] == tmp_size.sex
              @total_amount_female += est_mate['amount'].to_i
              @size_female.push({   name:tmp_size.name,
                                    breast:tmp_size.breast,
                                    long:tmp_size.long,
                                    amount:est_mate['amount'] })
            end
          end
        end
      end #JSON.parse(order.base_price)

      @texture = []
      JSON.parse(@order.stuff_picker).each do |pick|
        if pick['stuff_type_name'] == 'TYPE'
          @texture.push({   name:pick['texture_name'],
                            img:pick['texture_img'],
                            texture_price:pick['texture_price'],
                            id:pick['texture_id'] })
          break
        end
      end
      @logo = []
      JSON.parse(@order.stuff_picker).each do |pick|
        if pick['stuff_type_name'] == 'LOGO'
          if pick['logo_front_r']
            color = 0
            tmp_logo = StuffLogo.find(pick['logo_front_r']['img_id'])
            if tmp_logo
              if tmp_logo.color_number !=''
                color = tmp_logo.color_number
              end
            end
            @logo.push({   name:'logo_front_r',
                           img_path:pick['logo_front_r']['img_path'],
                           width:pick['logo_front_r']['width'],
                           height:pick['logo_front_r']['height'],
                           color_number:color
                       })
          end
          break
        end
      end
      @order
      @size_male
      @size_female
      @total_amount_male
      @total_amount_female
      @texture
      @total_amount = @total_amount_male + @total_amount_female
    end

  end

  def print_quotation
    @quotation = Quotation.quotation_report(params[:id])
    # get default setting
    @default = IdrReports::ReportFunctions.default_setting()
    # set render base reports
    @base = @default[:base_reports]
    @varible = [
      {
        page:'page1',
        item:['1', '2', '3', '4', '5', '6', '7', '8']
      }
    ]
    @patial_name = "print/quotation"
    @enable_header = false
    render :layout => false
  end

  def test_pdf
    @quotation = Quotation.quotation_report(Quotation.all().last())
    @base_url = "http://localhost:3000/"
    render "print/_quotation"
  end
end
