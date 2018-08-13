require "idr_reports/version"

module IdrReports
  class Engine < Rails::Engine

  end
  class ReportFunctions
    def self.default_setting(print_title = 'Print',cancel_title = 'Cancal',base_reports = 'idr_reports/base/body')
        return {
          'print_title': print_title,
          'cancel_title': cancel_title,
          'base_reports': base_reports,
        }
    end
  end
end
