class OrderController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.where(user: current_user).order("created_at desc")
  end
end
