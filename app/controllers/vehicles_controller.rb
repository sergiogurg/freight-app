class VehiclesController < ApplicationController
  before_action :set_shipping_company, only: [:index, :new, :create, :edit]
  before_action :vehicle_params, only: [:create, :update]
  before_action :set_vehicle, only: [:edit]

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
      redirect_to shipping_company_vehicles_path(@shipping_company.id)
    else
      flash.now[:notice] = 'Não foi possível cadastrar o veículo.'
      render 'new'
    end
  end

  def edit

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