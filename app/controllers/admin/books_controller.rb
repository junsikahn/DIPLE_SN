class Admin::BooksController < AdminController
  before_action :set_admin_book, only: [:show, :edit, :update, :destroy]

  # GET /admin/books
  # GET /admin/books.json
  def index
    @admin_books = Admin::Book.includes(:subject, :publisher).page(params[:page]).per(params[:per])
  end

  # GET /admin/books/1
  # GET /admin/books/1.json
  def show
  end

  # GET /admin/books/new
  def new
    @admin_book = Admin::Book.new
  end

  # GET /admin/books/1/edit
  def edit
  end

  # POST /admin/books
  # POST /admin/books.json
  def create
    @admin_book = Admin::Book.new(admin_book_params)
    @admin_book.ordering
    if @admin_book.save
      redirect_to @admin_book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/books/1
  # PATCH/PUT /admin/books/1.json
  def update
    if @admin_book.update(admin_book_params)
      @admin_book.ordering
      redirect_to @admin_book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/books/1
  # DELETE /admin/books/1.json
  def destroy
    @admin_book.destroy
    redirect_to admin_books_url, notice: 'Book was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_book
      @admin_book = Admin::Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_book_params
      params
        .fetch(:admin_book, {})
        .permit(:subject_id, :book_publisher_id, :name, :series, :total_page, :published_at,
                units_attributes: [:id, :subject_id, :book_id, :depth, :name, :page, :_destroy])
    end
end
