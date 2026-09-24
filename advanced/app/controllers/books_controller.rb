class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # 存在しないIDにアクセスされた場合は一覧に戻してメッセージを表示する
  rescue_from ActiveRecord::RecordNotFound do
    redirect_to books_path, alert: "指定された本が見つかりませんでした。"
  end

  # GET /books
  def index
    @keyword = params[:q].to_s.strip
    @books = Book.order(:published_year, :id)
    if @keyword.present?
      like = "%#{Book.sanitize_sql_like(@keyword)}%"
      @books = @books.where("title LIKE ? OR author LIKE ?", like, like)
    end
  end

  # GET /books/:id
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: "「#{@book.title}」を登録しました。"
    else
      flash.now[:alert] = "登録に失敗しました。入力内容を確認してください。"
      render :new, status: :unprocessable_entity
    end
  end

  # GET /books/:id/edit
  def edit
  end

  # PATCH/PUT /books/:id
  def update
    if @book.update(book_params)
      redirect_to @book, notice: "「#{@book.title}」を更新しました。"
    else
      flash.now[:alert] = "更新に失敗しました。入力内容を確認してください。"
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /books/:id
  def destroy
    if @book.destroy
      redirect_to books_path, notice: "「#{@book.title}」を削除しました。", status: :see_other
    else
      redirect_to books_path, alert: "削除に失敗しました。", status: :see_other
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :published_year)
  end
end