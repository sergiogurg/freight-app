class VehiclesController < ApplicationController
  before_action :set_shipping_company
  before_action :set_vehicle, only: [:edit, :update]

  def index
    @vehicles = Vehicle.all
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params())
    if @vehicle.save()
      flash[:notice] = 'Veículo cadastrado com sucesso.'
      redirect_to shipping_company_vehicles_path
    else
      flash.now[:notice] = 'Não foi possível cadastrar o veículo.'
      render 'edit'
    end
  end

  def edit; end

  def update
    if @vehicle.update(vehicle_params())
      flash[:notice] = 'Veículo atualizado com sucesso.'
      redirect_to shipping_company_vehicles_path(@shipping_company.id)
    else
      flash.now[:notice] = 'Não foi possível atualizar o veículo.'
      render 'new'
    end

  end

  private

  def set_shipping_company
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_params
    vp = params.require(:vehicle).permit(:id_plate, :make, :model, :year, :load_capacity)
    vp.merge!({shipping_company: set_shipping_company()})
    return vp
  end
end