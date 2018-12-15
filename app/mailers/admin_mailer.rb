# require "pdfkit"
require 'open-uri'
require 'base64'
include ActionView::Helpers::NumberHelper

class AdminMailer < ApplicationMailer
  default from: 'onlinesale.ipolo@gmail.com'

  def send_quotation(send_to_email,quotation,base_url)

    @quotation = Quotation.quotation_report(quotation.id)
    @base_url = base_url

    if @quotation[:stuff_details]
      quotation_details = ""
      @quotation[:stuff_details].each_with_index do |stuff,index|
        if stuff[:stuff_type_name]
          if stuff[:stuff_type_name] == 'TYPE'
            quotation_details_desc = stuff[:desc]
            quotation_details_texture_name = stuff[:texture_name]
            quotation_details_total_amount = @quotation[:total_amount]
            if @quotation[:total] and  @quotation[:total_amount]
              quotation_details_total_amount_total = number_with_precision(( @quotation[:total]/ @quotation[:total_amount]).ceil, precision: 0, delimiter: ',')
            end
            quotation_details_total = number_with_precision( @quotation[:total].ceil, precision: 0, delimiter: ',')
            quotation_details = quotation_details + "<tr>
                      <td style='text-align: center;'>
                        #{index+1}
                      </td>
                      <td> แบบเสื้อตามแบบ
                       #{quotation_details_desc}
                      </td>
                      <td></td>
                      <td></td>
                      <td></td>
                      <td></td>
                    </tr>
                    <tr>
                      <td></td>
                      <td> - เนื้อผ้า
                        #{quotation_details_texture_name}
                      </td>
                      <td style='text-align: center;'>
                         #{quotation_details_total_amount}

                      <td style='text-align: center;'>ตัว</td>
                      <td style='text-align: center;'>
                        #{quotation_details_total_amount_total}
                      </td>
                      <td style='text-align: right;'>
                        #{quotation_details_total}
                      </td>
                    </tr>"
          else
            quotation_details_desc = stuff[:desc]
            quotation_details = quotation_details + "<tr><td></td><td> -
                        #{quotation_details_desc}</td><td></td><td></td><td></td><td></td></tr>"
          end
        end
      end
    end

    if  @quotation[:estimate_cost]
      quotation_estimate_cost = ""
      quotation_estimate_cost = quotation_estimate_cost + "<tr><td></td><td>"
      @check_male = false
      JSON.parse( @quotation[:estimate_cost]).each do |size|
        if size['size'].split('_')[1] == 'male' && size['amount'] != ''
          @check_male = true
          break
        end
      end

      @check_female = false
      JSON.parse( @quotation[:estimate_cost]).each do |size|
        if size['size'].split('_')[1] == 'female' && size['amount'] != ''
          @check_female = true
          break
        end
      end
      quotation_estimate_cost = quotation_estimate_cost + "<table><tr>"
      if @check_male
        quotation_estimate_cost = quotation_estimate_cost + "<td>ชาย</td>"
      end
      if @check_female
        quotation_estimate_cost= quotation_estimate_cost + "<td>หญิง</td>"
      end
      quotation_estimate_cost = quotation_estimate_cost + "</tr><tr>"
      if @check_male
        quotation_estimate_cost = quotation_estimate_cost + "<td>
                      <div style='width: 50% !important;display: inline-block;float: left !important;'>
                        <b>ขนาด</b>
                      </div>
                      <div style='width: 50% !important;display: inline-block;float: left !important;'>
                        <b>จำนวน</b>
                      </div>"
         JSON.parse( @quotation[:estimate_cost]).each do |size|
            if size['size'].split('_')[1] == 'male' && size['amount'] != ''
              quotation_estimate_cost = quotation_estimate_cost + "<div style='width: 50% !important;display: inline-block;float: left !important;'>#{size['size'].split('_')[0]}</div><div style='width: 50% !important;display: inline-block;float: left !important;'>#{size['amount']}  </div>"
            end
         end
        quotation_estimate_cost = quotation_estimate_cost + "</td>"
      end

      if @check_female
        quotation_estimate_cost = quotation_estimate_cost + "<td>
                      <div style='width: 50% !important;display: inline-block;float: left !important;'>
                        <b>ขนาด</b>
                      </div>
                      <div style='width: 50% !important;display: inline-block;float: left !important;'>
                        <b>จำนวน</b>
                      </div>"
        JSON.parse( @quotation[:estimate_cost]).each do |size|
          if size['size'].split('_')[1] == 'female' && size['amount'] != ''
            quotation_estimate_cost = quotation_estimate_cost + "<div style='width: 50% !important;display: inline-block;float: left !important;'>#{size['size'].split('_')[0]}</div><div style='width: 50% !important;display: inline-block;float: left !important;'>#{size['amount']}  </div>"
          end
        end
        quotation_estimate_cost = quotation_estimate_cost + "</td>"
      end
      quotation_estimate_cost = quotation_estimate_cost + "</tr></table></td><td></td><td></td><td></td><td></td></tr>"

    end

    if @quotation[:stuff_image] and base_url
      # img = open(base_url + @quotation[:stuff_image])
      # puts ::Base64.encode64(img.read)
      # stuff_img_path = "data:image/png;base64,#{::Base64.encode64(img.read)}"

      stuff_img_path = "data:image/png;base64,#{::Base64.encode64(open(base_url + @quotation[:stuff_image]) { |io| io.read })}"
      # stuff_img_path = ""
    end
    if  @quotation[:total]
      total = number_with_precision( @quotation[:total], precision: 2, delimiter: ',')
    end
    if  @quotation[:total_vat]
      total_vat = number_with_precision( @quotation[:total_vat], precision: 2, delimiter: ',')
    end
    if  @quotation[:total_vat] and  @quotation[:total]
      total_vat_total = number_with_precision(( @quotation[:total_vat] +  @quotation[:total]), precision: 2, delimiter: ',')
    end

    if @quotation[:admin_username]!='anonymous'
      company_name = @quotation[:admin_username]
    else
      company_name = 'บริษัท'
    end
    if base_url
      image_data = Rails.application.assets['print/por_sign.png'].to_s
      sign_src_img = "data:image/png;base64,#{::Base64.encode64(image_data)}"
      sign_img_path = sign_src_img
    end

    if @quotation[:stuff_picker]
      stuff_picker = JSON.parse(@quotation[:stuff_picker])
      logo_list = ""
      all_stuff_logo = Stuff.where(stuff_type:StuffType.where({name:'LOGO'}).first);
      all_stuff_logo.each do |logo|
        stuff_picker.each do |picker|
          if picker["stuff_type_name"]=="LOGO"
            if picker[logo.name]
              tmp_logo = StuffLogo.find(picker[logo.name]['img_id'])
              type = ""
              if  tmp_logo.logo_type == "screen"
                type = "สกรีน"
              else
                type = "ปัก"
              end
              logo_list = logo_list + "<li class='logo_details'>#{type} #{logo.desc} #{tmp_logo.color_number}สี ขนาด #{tmp_logo.logo_width}ซม.x #{tmp_logo.logo_height}ซม.</li>"
            end
          end
        end
      end

    end
    # kit = PDFKit.new(" doc
    pdf = WickedPdf.new.pdf_from_string("
    <meta content='text/html; charset=utf-8' http-equiv='content-type' />
    <style>
        @font-face {
          font-family: 'THSarabunNewRegular';
          src: url('http://webfont.webdesigner.in.th/font/THSarabunNew/thsarabunnew.eot');
          src: url('http://webfont.webdesigner.in.th/font/THSarabunNew/thsarabunnew.eot') format('embedded-opentype'),
               url('http://webfont.webdesigner.in.th/font/THSarabunNew/thsarabunnew.woff') format('woff'),
               url('http://webfont.webdesigner.in.th/font/THSarabunNew/thsarabunnew.ttf') format('truetype'),
               url('http://webfont.webdesigner.in.th/font/THSarabunNew/thsarabunnew.svg#THSarabunNewRegular') format('svg');
      }
      *{
        font-family: THSarabunNewRegular;
        font-size:22px;
        line-height: 1;
      }
      // all
      td {
        padding: 10px 0px 0px 0px;
      }
      // section1
      .section1{
        font-size: 0.85em;
      }
      // section2
      .section2{
        margin-top: 5px;
        position: relative;
      }
      .report-title{
        margin:0px;
        font-size:1.2em;
      }
      .line-image{
        background-color: #4a6696;
        height: 3px;
        margin: 10px;
      }
      .address-text{
        padding-top: 5px;
        font-size:0.8em;
      }
      // section3
      .section3{
        margin-top: 10px;
      }

      .border-table{
        border: 1px solid;
        border-radius: 20px;
        padding: 12px 15px 5px 15px;
      }
      .first-detail{

      }
      .first-detail td:nth-child(1){
        width:1.5cm;
        text-align: center;
        font-weight: bold;
      }
      .first-detail td:nth-child(2){
        width:12cm;
        border-bottom: 1px solid blue;
      }
      .first-detail td:nth-child(3){
        width:3cm;
        text-align: center;
        font-weight: bold;

      }
      .first-detail td:nth-child(4){
        width:4cm;
        border-bottom: 1px solid blue;
        text-align: center;

      }
      .second-detail{

      }
      .second-detail td:nth-child(1){
        width:1.5cm;
        text-align: center;
        font-weight: bold;

      }
      .second-detail td:nth-child(2){
        width:7cm;
        border-bottom: 1px solid blue;
      }
      .second-detail td:nth-child(3){
        width:3.5cm;
        text-align: center;
        font-weight: bold;
      }
      .second-detail td:nth-child(4){
        width:8.5cm;
        border-bottom: 1px solid blue;
      }

      // section4
      .section4{
        margin-top: 10px;
      }

      .item-box{
        border-collapse:collapse;
      }
      .item-box td{
        border-left:1px solid;
        border-right:1px solid;
        padding-left: 5px;
        padding-right: 5px;
      }
      .item-box tr:nth-child(1) td{
        padding: 5px 2px 2px 2px;
        border:1px solid;
        text-align: center;
        background: #ccc;
        font-weight: bold;
      }
      .item-box .footer-item td{
        padding: 10px 5px 10px 5px;
        border:1px solid;
        text-align: center;
        font-weight: bold;
        line-height: 85%;
      }

      // section5
      .section5{
        margin-top: 10px;
        width:100%;

      }
      .confirm-box{
        font-weight: bold;
        border-collapse: collapse;
      }
      .confirm-box td{
        border:1px solid;
        padding: 5px;
      }

      .confirm-box-1 td:nth-child(1){
        padding-left: 15px;
        width:50%;
      }
      .confirm-box-1 td:nth-child(2){
        text-align: center;
        width:50%;
      }
      ._text-center{
        text-align: center;
      }
      .address-section{
        text-align:center;
      }
      .payment-desc{
        font-size:1em;
        line-height:0.8;
      }
      .logo_details{
        font-size:0.8em;
      }
      .quotation_sign{

      }
      </style>

      <div class='section2'>
        <div class='_text-center'><h2 class='report-title'>บริษัท ไอโปโล จำกัด IPOLO CO.,LTD </h2></div>
        <div class='line-image'></div>
        <div class='address-section'>
          <span class='address-text' >เลขที่ 5 ซ.เอกชัย 89/1 ถ.เอกชัย แขวงบางบอน เขตบางบอกน กรุงเทพ 10150 เลขประจำตัวผู้เสียภาษี  0-1055-47061-02-5
          </span>
          <br>
          <span class='address-text'>โทร. 0-2894-5445-7 แฟกซ์. 0-2894-5448 Website : www.ipolo.co.th Email : info@ipolo.co.th
          </span>
        </div>
        <div class='_text-center'><h2 class='report-title'>ใบเสนอราคา / ใบยืนยันการสั่งซื้อ</h2></div>
      </div>
      <div class='section3'>
        <div class='border-table'>
          <table class='first-detail'>
            <tr class='first-column'>
              <td>ผู้สั่งซื้อ</td>
              <td>
                #{
          if @quotation[:company_name]
            @quotation[:company_name]
          end}
                           #{
                           if @quotation[:first_name]
                             @quotation[:first_name]
                           end}
              </td>
              <td>เลขที่</td>
              <td></td>
            </tr>
            <tr>
              <td>ที่อยู่</td>
              <td>
                #{
          if @quotation[:address]
            @quotation[:address]
          end}
              </td>
              <td>พนักงานขาย</td>
              <td>
                #{company_name}
              </td>
            </tr>
            <tr>
              <td></td>
              <td></td>
              <td>วันที่เสนอราคา</td>
              <td>
                #{
          if @quotation[:updated_at]
            @quotation[:updated_at]
          end}
              </td>
            </tr>
          </table>
          <table class='second-detail'>
            <tr>
              <td>โทร</td>
              <td>
                #{
          if @quotation[:tel]
            @quotation[:tel]
          end}
              </td>
              <td>เงื่อนไขการชำระเงิน</td>
              <td>
                #{
          if @quotation[:credit_name]
            @quotation[:credit_name]
          end}
                           #{
                           if @quotation[:pledge_name]
                             @quotation[:pledge_name]
                           end}

              </td>
            </tr>
            <tr>
              <td>แฟกซ์</td>
              <td>
                #{
          if @quotation[:fax]
            @quotation[:fax]
          end}
              </td>
              <td>ระยะเวลาการส่งสินค้า</td>
              <td>ขึ้นกับตัวงานและจำนวนจะมีพนังงานแจ้งอีกครั้ง</td>
            </tr>
            <tr>
              <td>ผู้ติดต่อ</td>
              <td>
                #{
          if @quotation[:first_name]
            @quotation[:first_name]
          end}
              </td>
              <td>อีเมล์</td>
              <td>
                #{
          if @quotation[:email]
            @quotation[:email]
          end}
              </td>
            </tr>
          </table>
        </div>
      </div>
      <div class='section4'>
        <table class='item-box'>
          <tr >
            <td style='width:1.7cm !important;'>เลขที่</td>
            <td style='width:8.5cm !important;'>รายละเอียด</td>
            <td style='width:2.0cm !important;'>จำนวน</td>
            <td style='width:1.7cm !important;'>หน่วย</td>
            <td style='width:2.3cm;'>ราคา/หน่วย</td>
            <td style='width: 3cm;'>จำนวนเงิน</td>
          </tr>
          #{quotation_details}
          #{quotation_estimate_cost}
          <tr>
            <td></td>
            <td align='left'>
              <div style='display:inline-block;width:45%;'>
                <img src='#{stuff_img_path}' style='width: 100%;margin-top:3px;margin-bottom:3px;'>
              </div>
              <div style='display:inline-block;width:45%;'>
                <ul clss='logo_details'>
                  #{logo_list}
                </ul>
              </div>
            </td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          <tr class='footer-item'>
            <td rowspan='3' colspan='2'><p>ราคานี้จะปรับเปลี่ยนกรณี Size ที่สรุปเฉลี่ยเกินกว่า Size L </p><p> ห้ามหักภาษี ณ ที่จ่าย 3% </p><p> กำหนดยืนราคา 15 วัน นับจากวันที่เสนอราคา</p></td>
            <td colspan='3'>ยอดรวมมูลค่าสินค้า (ไม่รวมภาษี)</td>
            <td >
              <div style='float: right' >
                #{total}
              </div>
            </td>
          </tr>
          <tr class='footer-item'>
            <td colspan='3'>ภาษีมูลค่าเพิ่ม 7%</td>
            <td >
              <div style='float: right' >
                #{total_vat}
              </div>
            </td>
          </tr>
          <tr class='footer-item'>
            <td colspan='3'>ยอดรวมภาษีมูลค่าเพิ่ม</td>
            <td >
              <div style='float: right' >
                #{total_vat_total}
              </div>
            </td>
          </tr>
        </table>
      </div>
      <div class='section5'>
        <table class='confirm-box'>
          <tr class='confirm-box-1' >
              <td rowspan='2' class='payment-desc' style='width:20cm;'>
                  <p class='payment-desc'>กรณีชำระสินค้าโดยการโอนเงิน</p>
                  <p class='payment-desc'>ชื่อบัญชี : บริษัท ไอโปโล จำกัด</p>
                  <p class='payment-desc'>ธนาคาร กสิกรไทย บัญชี : กระแสรายวัน</p>
                  <p class='payment-desc'>หมายเลขบัญชี: 055-1-10061-8 สาขา : บางบอน</p>
                  <p class='payment-desc'>ธนาคารกรุงไทย บัญชี : กระแสรายวัน</p>
                  <p class='payment-desc'>หมายเลขบัญชี: 075-6-02592-3 สาขา: บางบอน</p>
                  <p class='payment-desc'>กรุณาแฟ็กซ์หลักฐานการโอนเงินมาที่ 0-2894-5448</p>
                  <p class='payment-desc'>พร้อมระบุชื่อสินค้า,ชื่อผู้โอน และเบอร์ติดต่อกลับ</p>
                  <p class='payment-desc'>กรณีชำระสินค้าโดยการตีเช็ค</p>
                  <p class='payment-desc'>สั่งจ่ายในนาม บริษัท ไอโปโล จำกัด</p>
              </td>
              <td style='width:20cm;'>
                <div style='height:1.8cm;'>กรุณาเช็นสั่งซื้อ พร้อมประทับตรา</div><br>
                <span style=''>ผู้มีอำนาจในการสั่งซื้อ / ผู้สั่งซื้อ</span>
              </td>
          </tr>
          <tr>
           <td class='_text-center quotation_sign'>
              <img src='#{sign_img_path}' style='width:60%;'><br>
              บริษัท ไอโปโล จำกัด
           </td>
          </tr>
        </table>
      </div>", encoding: "UTF-8", page_size:"A4")

    # MOST EZ WAY BUT NOT WORK !!!!!!
    # kit = PDFKit.new(render "print/pdf_quotation", page_size: 'A4', locals: { quotation: @quotation ,base_url:@base_url},:layout => false)
    # kit.to_file("#{Rails.root}/public/pdfs/quotation_#{quotation.id}.pdf")
    # kit.to_file(Rails.root.join("public","pdfs","quotation_#{quotation.id}.pdf"))

    # pdf_file  = kit.to_file(Rails.root.join("public","pdfs","quotation_#{quotation.id}.pdf"))
    # then save to a file

    save_path = Rails.root.join("public","pdfs","quotation_#{quotation.id}.pdf")
    File.open(save_path, 'wb') do |file|
      file << pdf
    end

    attachments["quotation_#{quotation.id}.pdf"] = File.read(save_path)

    # get default setting
    @default = IdrReports::ReportFunctions.default_setting()
    # set render base reports
    @base = @default[:base_reports]
    @varible = [
        { page:'page1',
          item:['1', '2', '3', '4', '5', '6', '7', '8'],
        },
    # {'page': 'page2',
    #  'item': [ '9', '10', '11', '12', '13'],
    # },
    ]
    @patial_name = "print/quotation"
    @enable_header = true
    mail(to: send_to_email, subject: 'IPOLO (ipolo) ใบเสนอราคา')
  end

end
