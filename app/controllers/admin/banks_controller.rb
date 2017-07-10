class Admin::BanksController < AdminController
  before_action :set_admin_bank, only: [:show, :edit, :update, :destroy]

  # GET /admin/banks
  # GET /admin/banks.json
  def index
    @admin_banks = Admin::Bank.page(params[:page]).per(params[:per])
  end

  # GET /admin/banks/1
  # GET /admin/banks/1.json
  def show
  end

  # GET /admin/banks/new
  def new
    @admin_bank = Admin::Bank.new
  end

  # GET /admin/banks/1/edit
  def edit
  end

  # POST /admin/banks
  # POST /admin/banks.json
  def create
    @admin_bank = Admin::Bank.new(admin_bank_params)

    respond_to do |format|
      if @admin_bank.save
        format.html { redirect_to @admin_bank, notice: 'Bank was successfully created.' }
        format.json { render :show, status: :created, location: @admin_bank }
      else
        format.html { render :new }
        format.json { render json: @admin_bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/banks/1
  # PATCH/PUT /admin/banks/1.json
  def update
    respond_to do |format|
      if @admin_bank.update(admin_bank_params)
        format.html { redirect_to @admin_bank, notice: 'Bank was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_bank }
      else
        format.html { render :edit }
        format.json { render json: @admin_bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/banks/1
  # DELETE /admin/banks/1.json
  def destroy
    @admin_bank.destroy
    respond_to do |format|
      format.html { redirect_to admin_banks_url, notice: 'Bank was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_bank
      @admin_bank = Admin::Bank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_bank_params
      params.require(:admin_bank).permit(:name)
    end
end
