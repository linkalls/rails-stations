class Admin::MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
      if @movie.save
        redirect_to admin_movies_path, notice: 'Movie was successfully created.'
      else
        # flash[:danger] = "うまく登録できませんでした"
        render "new",status: :unprocessable_entity
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def destroy
    @movie = Movie.find(params[:id])
    if @movie.delete
      flash[:success] = "削除しました"
      redirect_to admin_movies_path
    else
      render "edit",status: :unprocessable_entity
    end
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(movie_params)
    if @movie.save
      flash[:success] = "更新に成功しました"
      redirect_to admin_movies_path
    else
      render "edit", status: :unprocessable_entity
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:name, :year, :is_showing,:description,:image_url)
  end

end
