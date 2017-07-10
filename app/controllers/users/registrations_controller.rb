class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  skip_before_action :redirect_if_unverified

  # GET /resource/sign_up
  def new
    # super
    build_resource({})
    yield resource if block_given?
    respond_with resource
  end

  # POST /resource
  def create
    # super
    build_resource(sign_up_params)
    resource.agreed_at = Time.now
    resource.save
    yield resource if block_given?
    if resource.persisted?
      set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
      sign_up(resource_name, resource)
      respond_with resource, location: after_inactive_sign_up_path_for
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource
  def show
    render :show
  end

  # GET /resource/edit
  def edit
    redirect_to users_profile_path
    # super
  end

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
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :agreed_at])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :name, :gender, :birthday, :phone, :email, :address])
  # end

  # def update_resource(resource, params)
  #   # resource.update_with_password(params)
  #   resource.update_without_password(params)
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  #   after_sign_in_path_for(resource)
  # end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for
    # super(resource)
    # scope = Devise::Mapping.find_scope!(resource)
    # router_name = Devise.mappings[scope].router_name
    # context = router_name ? send(router_name) : self
    # context.respond_to?(:root_path) ? context.root_path : "/"
    users_verify_path
  end

  # def after_update_path_for(resource)
  #   # super
  #   # signed_in_root_path(resource)
  #   users_profile_path
  # end
end
