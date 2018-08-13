class AddFaxToOrderAndQuotation < ActiveRecord::Migration
  def change

    add_column :orders, :fax, :string, default: ""
    add_column :quotations, :fax, :float, default: ""

  end
end
