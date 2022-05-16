class ShippingCompaniesController < ApplicationController

  def index
    @shipping_companies = ShippingCompany.all
  end

  def new
    @shipping_company = ShippingCompany.new
  end

  def create
    shipping_company_params = params.require(:shipping_company).permit(:corporate_name, :brand_name, :registration_number, :email_domain, :address)
    @shipping_company = ShippingCompany.new(shipping_company_params)
    if @shipping_company.save()
      flash[:notice] = 'Transportadora cadastrada com sucesso'
      redirect_to shipping_companies_path
    else
      flash.now[:notice] = 'Não foi possível cadastrar a transportadora'
      render :new
    end
  end

  def show
    @shipping_company = ShippingCompany.find(params[:id])
  end

  def edit
    @shipping_company = ShippingCompany.find(params[:id])
  end

end