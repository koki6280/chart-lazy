class BooksController < ApplicationController
	before_action :authenticate_user!
  def index
  	@books = Book.all
  	@book = Book.new
  	# @user = current_user
  end

  def show
  	@book = Book.find(params[:id])
  	@user = @book.user
  end

  def new
  end

  def create
     @book = Book.new(book_params)
     @book.user_id = current_user.id
    if  @book.save
        flash[:notice] = "Book was successfully created."
        redirect_to book_path(@book.id)
    else
    	@books = Book.all
    	flash.now[:alert] = 'error'
    	render action: :index
    end
  end

  def edit
	  	    @book = Book.find(params[:id])
	  	if
	  		@book.user_id == current_user.id
	  		render action: :edit
	  	else
	  		redirect_to books_path
	  	end
  end

  def update
  	@book = Book.find(params[:id])
  	if  @book.update(book_params)
  		flash[:notice] = "You have creatad book successfully."
  	    redirect_to book_path(@book)
  	else
  		flash.now[:alert] = 'error'
        render action: :edit
  	end
  end

  def destroy
  	book = Book.find(params[:id])
  	if book.destroy
  		flash[:notice] = "You have updated book successfully."
        redirect_to books_path(@books)
    else
    	render action: :new
    end
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
