class DeliveryTimesController < ApplicationController
  before_action :set_shipping_company
  before_action :only_admin_or_user_allowed

  def index
    @delivery_times = DeliveryTime.all
  end

  def new
    @delivery_time = DeliveryTime.new
  end

  def create
    @delivery_time = DeliveryTime.new(delivery_time_params())
    if avoid_overlapping(@delivery_time.initial_distance)
      flash.now[:notice] = 'A distância inicial está contida em um intervalo já cadastrado.'
      render 'new'
    elsif avoid_overlapping(@delivery_time.final_distance)
      flash.now[:notice] = 'A distância final está contida em um intervalo já cadastrado.'
      render 'new'
    elsif @delivery_time.save()
      flash[:notice] = 'Intervalo de Prazos cadastrado com sucesso.'
      redirect_to shipping_company_delivery_times_path
    else
      flash.now[:notice] = 'Não foi possível cadastrar o interavalo.'
      render 'new'
    end
  end

  private

  def set_shipping_company
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
  end

  def set_delivery_time
    @delivery_time = DeliveryTime.find(params[:id])
  end

  def delivery_time_params
    dtp = params.require(:delivery_time).permit(:initial_distance, :final_distance, :weekdays)
    dtp.merge!({shipping_company: set_shipping_company()})
    return dtp
  end

  def avoid_overlapping(distance)
    flag = false
    query = DeliveryTime.where('initial_distance <= ? AND final_distance >= ?', distance, distance)
    if query.any?
      flag = true
    end
    return flag
  end

  def only_admin_or_user_allowed
    if !admin_signed_in? && !user_signed_in?
      flash[:notice] = 'Área permitida somente para Admins e Usuários'
      redirect_to root_path
    end
  end

end