class Users::BankInfosController < Users::ProfilesController
  def edit
  end

  def update
    return if current_user.mentor.update(bank_params)
    render :edit
  end

  protected

  def bank_params
    params
      .fetch(:mentor, {})
      .permit(:bank_name, :account_number)
  end
end
