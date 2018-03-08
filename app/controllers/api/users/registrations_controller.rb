module Api
  module Users
    class RegistrationsController < Devise::RegistrationsController
      before_action :configure_sign_up_params, only: [:create]
      before_action :configure_account_update_params, only: [:update]

      # POST /resource
      def create
        errors = {}
        required = [:uid, :password, :password_confirmation, :name, :gender, :liberal, :birthday]
        unless required.all? {|k| !sign_up_params[k].blank?}
          errors[:uid] = '학번을 입력해주세요' if sign_up_params[:uid].blank?
          errors[:password] = '비밀번호를 입력해주세요' if sign_up_params[:password].blank?
          errors[:password_confirmation] = '비밀번호를 확인해주세요' if sign_up_params[:password_confirmation].blank?
          errors[:name] = '이름을 입력해주세요' if sign_up_params[:name].blank?
          errors[:gender] = '성별을 선택해주세요' if sign_up_params[:gender].blank?
          errors[:liberal] = '전공을 선택해주세요' if sign_up_params[:liberal].blank?
          errors[:birthday] = '생년월일을 선택해주세요' if sign_up_params[:birthday].blank?
          return render json: { errors: errors }, status: :bad_request
        end
        unless Devise.password_length.member?(sign_up_params[:password].length)
          errors[:password] = "비밀번호는 #{Devise.password_length.min}자 이상 #{Devise.password_length.max}자 이하로 입력해주세요"
          return render json: { errors: errors }, status: :bad_request
        end
        if sign_up_params[:password] != sign_up_params[:password_confirmation]
          errors[:password_confirmation] = '비밀번호 확인이 불일치합니다'
          return render json: { errors: errors }, status: :bad_request
        end
        unless User.find_for_database_authentication(uid: sign_up_params[:uid]).blank?
          errors[:uid] = '이미 존재하는 유저입니다'
          return render json: { errors: errors }, status: :not_found
        end
        self.resource = build_resource(sign_up_params)
        if sign_up(resource_name, resource)
          return render json: { profile: resource, token: resource.id }, status: :ok
        end
      end

      # PUT /resource
      # def update
      #   valid_user = resource.valid_password?(params[:user][:password])
      #   valid_new_password = params[:user][:new_password] == params[:user][:password_confirmation]
      #   if !valid_user
      #     clean_up_passwords resource
      #     resource.errors.add(:password)
      #     render :edit
      #   elsif !valid_new_password
      #     resource.errors.add(:password_confirmation)
      #     render :edit
      #   else
      #     resource.update(password: params[:user][:new_password])
      #     bypass_sign_in resource, scope: resource_name
      #     respond_with resource, location: after_sign_in_path_for(resource)
      #   end
      # end

      # DELETE /resource
      # def destroy
      #   super
      # end

      protected

      # If you have extra params to permit, append them to the sanitizer.
      def configure_sign_up_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :gender, :birthday, :liberal])
      end

      # If you have extra params to permit, append them to the sanitizer.
      # def configure_account_update_params
      #   devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :name, :gender, :birthday, :phone, :email, :address])
      # end

      # def update_resource(resource, params)
      #   # resource.update_with_password(params)
      #   resource.update_without_password(params)
      # end
    end
  end
end
