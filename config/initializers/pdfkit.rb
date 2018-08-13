# PDFKit.configure do |config|
#
#   if Rails.env.production?
#     config.wkhtmltopdf = "#{ENV['GEM_HOME']}/bin/wkhtmltopdf"
#     # /usr/local/bundle/bin/wkhtmltopdf_test
#     config.default_options = {
#         :page_size => 'A4',
#         :print_media_type => true
#     }
#   else
#     config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'
#     config.default_options = {
#         :page_size => 'A4',
#         :print_media_type => true
#     }
#   end
#
# end