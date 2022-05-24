class VolumePricesController < ApplicationController
  before_action :set_shipping_company
  before_action :set_volume_price, only: [:edit, :update]

  def index
    @volume_prices = VolumePrice.all
  end
  
  def new
    @volume_price = VolumePrice.new
  end

  def create
    @volume_price = VolumePrice.new(volume_price_params())
    if avoid_overlapping(@volume_price.initial_volume)
      flash.now[:notice] = 'O volume inicial está contido em um intervalo já cadastrado.'
      render 'new'
    elsif avoid_overlapping(@volume_price.final_volume)
      flash.now[:notice] = 'O volume final está contido em um intervalo já cadastrado.'
      render 'new'
    elsif @volume_price.save()
      flash[:notice] = 'Intervalo Preço-volume cadastrado com sucesso.'
      redirect_to shipping_company_volume_prices_path
    else
      flash.now[:notice] = 'Não foi possível cadastrar o interavalo Preço-volume.'
      render 'new'
    end
  end

  private

  def set_shipping_company
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
  end

  def set_volume_price
    @volume_price = VolumePrice.find(params[:id])
  end

  def volume_price_params
    vpp = params.require(:volume_price).permit(:initial_volume, :final_volume, :price)
    vpp.merge!({shipping_company: set_shipping_company()})
    return vpp
  end

  def avoid_overlapping(volume)
    flag = false
    query = VolumePrice.where('initial_volume <= ? AND final_volume >= ?', volume, volume)
    if query.any?
      flag = true
    end
    return flag
  end

end