ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      table class:"dashboard-table" do
        thead do
          tr do
            th do
              "คู่มือการใช้งาน"
            end
          end
        end
        tbody do
          tr do
            td do
              a href:"#" do 
                "การใช้งานหลังบ้าน"
              end
            end
          end
          tr do
            td do
              a href: price_calculate_doc_path do 
                "ตัวอย่างการคำนวนราคาการคำนวนราคา"
              end
            end
          end
        end
      end

    end
  end
end
