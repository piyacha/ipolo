class AddCreditAndPledgesToQuotation < ActiveRecord::Migration
  def change
    add_column :quotations, :current_credit, :float, default: 1
    add_column :quotations, :current_pledge, :float, default: 1
  end
end
