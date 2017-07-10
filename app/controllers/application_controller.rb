class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :redirect_if_unverified
  around_action :set_current_user

  private

  def redirect_if_unverified
    return unless user_signed_in? && !current_user.verified_at?
    redirect_to users_verify_path, notice: "휴대폰번호를 인증해주세요! #{current_user.phone}번으로 PIN 번호를 전송하였습니다"
  end

  # Assign `current_user` to `Current.user` to access in model class
  def set_current_user
    Current.user = current_user
    yield
  ensure
    Current.user = nil # to address the thread variable leak issues in Puma/Thin webserver
  end
end
