class AddCompanyToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :company_name, :string, default: ""
    add_column :orders, :company_branch, :string, default: ""
    add_column :orders, :tax_identification_number, :string, default: ""
  end
end
