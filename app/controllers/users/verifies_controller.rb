class Users::VerifiesController < ApplicationController
  skip_before_action :redirect_if_unverified
  before_action :redirect_if_verified

  # GET /users/verify
  def show
    SendPinJob.perform_now(current_user) if !current_user.pin_sent_at?
    @user = User.new
  end

  # POST /users/verify
  def create
    @user = User.new
    if current_user.pin_sent_at? && Time.now > current_user.pin_sent_at.advance(minutes: 5)
      flash[:warning] = "입력 시간 초과로 PIN 번호가 파기되었습니다. 새로운 PIN 번호를 #{current_user.phone_number} 번으로 전송해드리겠습니다."
      SendPinJob.perform_later(current_user)
      render :show
    elsif params[:user][:pin].try(:to_i) == current_user.pin
      current_user.update_columns(pin: nil, pin_sent_at: nil, verified_at: Time.now)
      redirect_to users_role_path, notice: "감사합니다! #{current_user.phone_number} 번 휴대폰번호가 인증되었습니다"
    else
      flash[:error] = '입력하신 PIN 번호가 유효하지 않습니다'
      render :show
    end
  end

  # PUT /users/verify
  def update
    SendPinJob.perform_later(current_user)
    redirect_to users_verify_path, notice: "#{current_user.phone_number} 번으로 PIN 번호가 재발송되었습니다"
  end

  private

  def redirect_if_verified
    return unless current_user.verified_at?
    flash[:success] = '이미 인증되었습니다!'
    redirect_to users_role_path
  end
end
