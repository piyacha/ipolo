class AddProfitPledgeToQuotation < ActiveRecord::Migration
  def change
    add_reference :quotations, :credit, index: true
    add_reference :quotations, :pledge, index: true
  end
end
