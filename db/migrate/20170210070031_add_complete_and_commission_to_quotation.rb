class AddCompleteAndCommissionToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :commission, :float, default: 0
    add_column :quotations, :complete, :boolean, default: false
  end
end
