class Admin::SchedulesController < ApplicationController
  # def index
  #   # @movie_id = params[:movie_id] # 複数回ネストしてるからmovie_idとid(scheduleの)
  # end
  # def show
  #   @movie_id = params[:movie_id]
  #   @movie = Movie.find(@movie_id) # 複数回ネストしてるからmovie_idとid(scheduleの)
  #   @schedule_id = params[:id]
  #   @movie_schedule = @movie.schedules.find(@schedule_id)
  # end
  def edit
    @movie_id = params[:movie_id]
    @movie = Movie.find(@movie_id) # 複数回ネストしてるからmovie_idとid(scheduleの)
    @schedule_id = params[:id]
    @movie_schedule = @movie.schedules.find(@schedule_id)
  end

  def update
    @movie_id = params[:movie_id]
    @movie = Movie.find(@movie_id)
    @schedule_id = params[:id]
    @movie_schedule = @movie.schedules.find(@schedule_id)
    @movie_schedule.update(movie_schedule)
    if @movie_schedule.save
      flash[:success] = "変更完了"
      redirect_to admin_movie_schedule_path(@movie_id, @schedule_id)
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @movie_id = params[:movie_id]
    @movie = Movie.find(@movie_id)
    @schedule_id = params[:id]
    if @movie.schedules.find(@schedule_id).delete
      redirect_to admin_movies_path
    else
      render "edit", status: :unprocessable_entity
    end

  end

  private

  def movie_schedule
    params.require(:schedule).permit(:start_time, :end_time)
  end

end

