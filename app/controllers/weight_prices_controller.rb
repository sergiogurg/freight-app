class WeightPricesController < ApplicationController
  before_action :set_shipping_company
  before_action :set_weight_price, only: [:edit, :update]

  def index
    @weight_prices = WeightPrice.all
  end

  def new
    @weight_price = WeightPrice.new
  end

  def create
    @weight_price = WeightPrice.new(weight_price_params())
    if avoid_overlapping(@weight_price.initial_weight)
      flash.now[:notice] = 'O peso inicial está contido em um intervalo já cadastrado.'
      render 'new'
    elsif avoid_overlapping(@weight_price.final_weight)
      flash.now[:notice] = 'O peso final está contido em um intervalo já cadastrado.'
      render 'new'
    elsif @weight_price.save()
      flash[:notice] = 'Intervalo Preço-peso cadastrado com sucesso.'
      redirect_to shipping_company_weight_prices_path
    else
      flash.now[:notice] = 'Não foi possível cadastrar o interavalo Preço-peso.'
      render 'new'
    end
  end

  private

  def set_shipping_company
    @shipping_company = ShippingCompany.find(params[:shipping_company_id])
  end

  def set_weight_price
    @weight_price = WeightPrice.find(params[:id])
  end

  def weight_price_params
    wpp = params.require(:weight_price).permit(:initial_weight, :final_weight, :price)
    wpp.merge!({shipping_company: set_shipping_company()})
    return wpp
  end

  def avoid_overlapping(weight)
    flag = false
    query = WeightPrice.where('initial_weight <= ? AND final_weight >= ?', weight, weight)
    if query.any?
      flag = true
    end
    return flag
  end


end