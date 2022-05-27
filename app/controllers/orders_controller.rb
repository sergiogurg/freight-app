class OrdersController < ApplicationController
  before_action :only_admin_or_user_allowed
  before_action :order_params, only: [:create]

  def index
    @orders = Order.all
  end
  
  def new
    @order = Order.new
    @shipping_companies = ShippingCompany.all
  end

  def create
    @shipping_companies = ShippingCompany.all
    @order = Order.new(order_params)
    if @order.save
      flash[:notice] = 'Ordem de Serviço cadastrada com sucesso.'
      redirect_to orders_path
    else
      flash.now[:notice] = 'Não foi possível cadastrar a Ordem de Serviço.'
      render 'new'
    end
  end

  private

  def order_params
    params.require(:order).permit(:origin_address, :product_length, :product_height, :product_width, :product_weight, :destination_address, :shipping_company_id)
  end

  def only_admin_or_user_allowed
    if !admin_signed_in? && !user_signed_in?
      flash[:notice] = 'Área permitida somente para Admins e Usuários'
      redirect_to root_path
    end
  end

end