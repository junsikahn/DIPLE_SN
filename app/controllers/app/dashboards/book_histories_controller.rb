class App::Dashboards::BookHistoriesController < App::DashboardsController
  before_action :set_date_params

  def index
    @book_histories = BookHistory
                        .includes(book: [:subject, :publisher], details: :book_unit)
                        .where(match_id: params[:dashboard_id]).original_only.between(@start_date, @end_date)
  end

  def new
    @book_history = BookHistory.new(match_id: params[:dashboard_id])
  end

  def list
    return if book_list_params[:subject_id].blank? || book_list_params[:book_publisher_id].blank?
    @books = Standard::Book.where(book_list_params)
  end

  def create
    @book_history = BookHistory.new(book_history_params)
    @book_history.create_histories(book_history_params)
    return if @book_history.save
    render :new
  end

  def edit
    @book_history = BookHistory.includes(:book, details: :book_unit).find_by(id: params[:id], match_id: params[:dashboard_id])
  end

  def change_period
    @book_history = BookHistory.find(params[:id])
    @book_history.update(book_history_change_period_params)
    render :edit
  end

  def update
    @book_history = BookHistory.find(params[:id])
    @book_history_detail = BookHistory.find(params[:detail_id])
    if @book_history_detail.update(book_history_update_params)
      @book_history.reload
    else
      render :edit
    end
  end

  def rating
    @book_history = BookHistory.find(params[:id])
    @book_history.update(rating: params[:rating])
    head :ok
  end

  private

  def book_history_params
    params
      .fetch(:book_history, {})
      .permit(:match_id,
              :subject_id, :book_publisher_id, :book_id,
              :started_at, :planned_at)
  end

  def book_list_params
    params
      .fetch(:book_history, {})
      .permit(:subject_id, :book_publisher_id)
  end

  def book_history_change_period_params
    params
      .fetch(:book_history, {})
      .permit(:tag_color, :started_at, :planned_at)
  end

  def book_history_update_params
    params
      .permit(:planned_at, :completed_at)
  end
end
