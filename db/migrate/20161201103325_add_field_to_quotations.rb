class AddFieldToQuotations < ActiveRecord::Migration
  def change
    add_column :quotations, :first_name, :string, default: ""
    add_column :quotations, :last_name, :string, default: ""
    add_column :quotations, :address, :string, default: ""
    add_column :quotations, :tel, :string, default: ""
    add_column :quotations, :email, :string, default: ""
    add_column :quotations, :note, :string, default: ""

    add_column :quotations, :active, :boolean, default: true

    add_attachment :quotations, :stuff_img
    add_column :quotations, :stuff_picker, :string, default: ""
    add_column :quotations, :stuff_price, :string, default: ""
    add_column :quotations, :base_price, :string, default: ""

    add_column :quotations, :company_name, :string, default: ""
    add_column :quotations, :company_branch, :string, default: ""
    add_column :quotations, :tax_identification_number, :string, default: ""

    add_column :quotations, :estimate_cost, :string, default: ""
    add_column :quotations, :status, :string, default: ""
  end
end
