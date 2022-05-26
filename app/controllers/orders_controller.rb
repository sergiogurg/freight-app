class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end
  
  def new
    @order = Order.new
    @shipping_companies = ShippingCompany.all
  end

  def create
  end
end