class RouteUpdatesController < ApplicationController
  before_action :only_admin_or_user_allowed
  before_action :set_order

  def index
    
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