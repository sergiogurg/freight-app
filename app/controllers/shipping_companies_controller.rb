class ShippingCompaniesController < ApplicationController
  before_action :authenticate_admin!, except: [:show, :sc_orders, :tracking_form, :tracking_search]
  before_action :only_admin_or_user_allowed, only: [:show, :sc_orders]
  before_action :set_shipping_company, only: [:show, :edit, :update, :sc_orders]

  

  def index
    @shipping_companies = ShippingCompany.all
  end

  def new
    @shipping_company = ShippingCompany.new
  end

  def create
    @shipping_company = ShippingCompany.new(shipping_company_params())
    if @shipping_company.save()
      flash[:notice] = 'Transportadora cadastrada com sucesso'
      redirect_to shipping_companies_path
    else
      flash.now[:notice] = 'Não foi possível cadastrar a transportadora'
      render :new
    end
  end

  def show
    if user_signed_in? && current_user.shipping_company != @shipping_company
      flash[:notice] = 'Usuário, você foi redirecionado por tentar visualizar outra Transportadora.'
      redirect_to root_path
    end
  end

  def edit; end

  def update
    if @shipping_company.update(shipping_company_params())
      flash[:notice] = 'Transportadora atualizada com sucesso'
      redirect_to shipping_company_path
    else
      flash.now[:notice] = 'Não foi possível atualizar a transportadora'
      render :edit
    end
  end

  def budget_form; end

  def budget_search
    params.each_value do |value|
      if value.nil? || value.empty?
        flash[:notice] = 'Todos os campos são obrigatórios'
        redirect_to budget_form_shipping_companies_path and return
      end
    end

    length = params[:length].to_f / 100
    height = params[:height].to_f / 100
    width = params[:width].to_f / 100
    volume = volume_calculator(length: length, height: height, width: width)
    weight = params[:weight]
    distance = params[:distance].to_f

    vp_sc_names = []
    vp_prices = []
    vp_array = []
    wp_sc_names = []
    wp_prices = []
    wp_array = []
    dt_sc_names = []
    dt_weekdays = []
    dt_array = []
    ShippingCompany.all.each do |sc|
      vp = search_volume_price(volume: volume, distance: distance, sc_id: sc.id)
      if vp != nil
        vp_array << vp
        vp_sc_names << vp.shipping_company.brand_name
        vp_prices << vp.price
      end
      wp = search_weight_price(weight: weight, distance: distance, sc_id: sc.id)
      if wp != nil
        wp_array << wp
        wp_sc_names << wp.shipping_company.brand_name
        wp_prices << wp.price
      end
      dt = search_delivery_time(distance: distance, sc_id: sc.id)
      if dt != nil
        dt_array << dt
        dt_sc_names << dt.shipping_company.brand_name
        dt_weekdays << dt.weekdays
      end
    end

    # Somente as Transportadoras que preencheram todos os requisitos:
    sc_names = dt_sc_names.intersection(vp_sc_names, wp_sc_names)
    
    @flag_no_scs = false
    @flag_no_suitable_scs = false
    if ShippingCompany.all.empty?
      # Nenhuma Transportadora cadastrada.
      @flag_no_scs = true
    elsif sc_names.empty?
      # Nenhuma Transportadora atendeu aos requisitos.
      @flag_no_suitable_scs = true
    end

    dt_inters_weekdays = []
    vp_inters_prices = []
    wp_inters_prices = []
    sc_names.each do |sc_name|
      dt_array.each do |dt_datum|
        if dt_datum.shipping_company.brand_name == sc_name
          dt_inters_weekdays << dt_datum.weekdays
        end
      end
      vp_array.each do |vp_datum|
        if vp_datum.shipping_company.brand_name == sc_name
          vp_inters_prices << vp_datum.price
        end
      end
      wp_array.each do |wp_datum|
        if wp_datum.shipping_company.brand_name == sc_name
          wp_inters_prices << wp_datum.price
        end
      end
    end

    # (Preço por Volume + Preço por Peso) * Distância:
    prices = []
    range = 0..(sc_names.length - 1)
    for i in range do
      prices << (vp_inters_prices[i] + wp_inters_prices[i])*distance
    end
    @matrix = [sc_names, prices, dt_inters_weekdays].transpose()
  end

  def sc_orders
    @orders = Order.where(shipping_company: @shipping_company)
  end

  private

  def set_shipping_company
    @shipping_company = ShippingCompany.find(params[:id])
  end

  def shipping_company_params
    params.require(:shipping_company).permit(:corporate_name, :brand_name, :registration_number, :email_domain, :address)
  end

  def only_admin_or_user_allowed
    if !admin_signed_in? && !user_signed_in?
      flash[:notice] = 'Área permitida somente para Admins e Usuários'
      redirect_to root_path
    end
  end

  def volume_calculator(length:, height:, width:)
    length*height*width
  end

  def search_volume_price(volume:, distance:, sc_id:)
    volume_price_one_element_array = VolumePrice.where('initial_volume <= ? AND final_volume >= ? AND shipping_company_id == ?', volume, volume, sc_id)
    volume_price = volume_price_one_element_array[0]
    return volume_price
  end

  def search_weight_price(weight:, distance:, sc_id:)
    weight_price_one_element_array = WeightPrice.where('initial_weight <= ? AND final_weight >= ? AND shipping_company_id == ?', weight, weight, sc_id)
    weight_price = weight_price_one_element_array[0]
    return weight_price
  end

  def search_delivery_time(distance:, sc_id:)
    delivery_time_one_element_array = DeliveryTime.where('initial_distance <= ? AND final_distance >= ? AND shipping_company_id == ?', distance, distance, sc_id)
    delivery_time = delivery_time_one_element_array[0]
    return delivery_time
  end

end