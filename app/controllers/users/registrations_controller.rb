# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include Accessible
  skip_before_action :check_user, except: [:new, :create]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    user_password = params[:user][:password]
    user_email = params[:user][:email]
    user_email_domain = '@' + user_email.split('@').last
    ShippingCompany.all.each do |sc|
      if user_email_domain == sc.email_domain
        @user = User.new(email: user_email, password: user_password, shipping_company: sc)
      end
    end
    if @user == nil
      flash[:notice] = 'O domínio de email não pertence a nenhuma Transportadora.'
      redirect_to new_user_registration_path
    elsif @user.save()
      flash[:notice] = 'Bem vindo! Conta de Transportadora criada com sucesso.'
      redirect_to new_user_session_path
    else
      flash[:notice] = 'Erro ao criar conta de Transportadora.'
      redirect_to new_user_registration_path
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
