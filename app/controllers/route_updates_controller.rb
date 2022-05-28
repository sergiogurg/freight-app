class RouteUpdatesController < ApplicationController
  before_action :only_admin_or_user_allowed
  before_action :set_order

  def index
    @route_updates = RouteUpdate.where(order: @order)
  end

  def new
    @route_update = RouteUpdate.new
  end

  def create
    @route_update = RouteUpdate.new(date: Time.now.strftime("%d/%m/%Y"), time: Time.now.strftime("%H:%M"), order: @order)
    @route_update.current_location = params[:route_update][:current_location]
    if @route_update.save()
      flash[:notice] = 'Rota atualizada com sucesso.'
      redirect_to shipping_company_order_route_updates_path
    else
      flash.now[:notice] = 'Não foi possível atualizar a rota.'
      render 'new'
    end
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def only_admin_or_user_allowed
    if !admin_signed_in? && !user_signed_in?
      flash[:notice] = 'Área permitida somente para Admins e Usuários'
      redirect_to root_path
    end
  end

end