class OrdersController < ApplicationController
  before_action :authenticate_admin!, except: [:show, :flag_button, :approve, :update]
  before_action :only_admin_or_user_allowed, only: [:show, :flag_button, :approve, :update]
  before_action :order_params, only: [:create]
  before_action :set_order, only: [:show, :flag_button, :approve, :update]

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

  def show
    @flag_button_clicked = false
    if user_signed_in? && current_user.shipping_company != @order.shipping_company
      flash[:notice] = 'Usuário, você foi redirecionado por tentar visualizar uma Ordem de Serviço de outra Transportadora.'
      redirect_to root_path
    end
  end

  def flag_button
    @flag_button_clicked = true
    render 'show'
  end

  def update
    @order = Order.find(params[:id])
    @order.vehicle = Vehicle.find(params[:order][:vehicle_id])
    if @order.save()
      @order.approved!
      flash[:notice] = 'Ordem de Serviço aprovada com sucesso.'

      # Cria e vincula route_update:
      date = Time.now.strftime("%d/%m/%Y")
      time = Time.now.strftime("%H:%M")
      origin_location = @order.origin_address
      route_update = RouteUpdate.create!(date: date, time: time, current_location: origin_location, order: @order)
      redirect_to  shipping_company_order_path(@order.shipping_company.id, @order.id)
    else
      flash.now[:notice] = 'Não foi possível aprovar a Ordem de Serviço.'
      render 'show'
    end
  end

  def approve
    @order.approved!
    redirect_to shipping_company_order_path(@order.shipping_company_id, @order.id)
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

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