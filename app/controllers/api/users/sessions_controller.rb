module Api
  module Users
    class SessionsController < Devise::SessionsController
      before_action :configure_sign_in_params, only: [:create]

      def show
        return head :unauthorized unless current_user
        render json: { profile: current_user }, status: :ok
      end

      # POST /resource/sign_in
      def create
        errors = {}
        required = [:uid, :password]
        unless required.all? {|k| !sign_in_params[k].blank?}
          errors[:uid] = '학번을 입력해주세요' if sign_in_params[:uid].blank?
          errors[:password] = '비밀번호를 입력해주세요' if sign_in_params[:password].blank?
          return render json: { errors: errors }, status: :bad_request
        end
        self.resource = User.find_for_database_authentication(uid: sign_in_params[:uid])
        if resource.blank?
          errors[:uid] = '유저가 없습니다'
          return render json: { errors: errors }, status: :not_found
        end
        unless resource.valid_password?(sign_in_params[:password])
          errors[:password] = '비밀번호가 틀립니다'
          return render json: { errors: errors }, status: :unauthorized
        end
        sign_in(resource_name, resource)
        render json: { profile: resource, token: resource.id }, status: :ok
      end

      # DELETE /resource/sign_out
      def destroy
        Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
        head :ok
      end

      protected

      # If you have extra params to permit, append them to the sanitizer.
      def configure_sign_in_params
        devise_parameter_sanitizer.permit(:sign_in, keys: [])
      end
    end
  end
end
