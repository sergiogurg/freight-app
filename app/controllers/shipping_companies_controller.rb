class ShippingCompaniesController < ApplicationController
  before_action :authenticate_admin!, except: [:show]
  before_action :set_shipping_company, only: [:show, :edit, :update]

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

  private

  def set_shipping_company
    @shipping_company = ShippingCompany.find(params[:id])
  end

  def shipping_company_params
    params.require(:shipping_company).permit(:corporate_name, :brand_name, :registration_number, :email_domain, :address)
  end

end