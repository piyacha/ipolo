class AddFaxToQuotation < ActiveRecord::Migration
  def change
    remove_column :quotations, :fax
    add_column :quotations, :fax, :string, default: ""
  end
end
