class ReservationsController < ApplicationController
  def new
    # 必要なパラメータが欠けている場合はリダイレクト
    if params[:movie_id].blank? || params[:sheet_id].blank? || params[:date].blank?
      return redirect_to movies_path
    end
    @reservation = Reservation.new
    redirect_to reservation_movie_path(params[:movie_id], sheet_id: params[:sheet_id], date: params[:date])
  end

  def create
    # @movie = Movie.find(params[:movie_id])
    # @schedule = @movie.schedules.find(params[:schedule_id])
    @schedule = Schedule.find(params[:reservation][:schedule_id])
    @reservation = @schedule.reservations.new(
      name: params[:reservation][:name], email: params[:reservation][:email], date: params[:reservation][:date], sheet_id: params[:reservation][:sheet_id],
      schedule_id: params[:reservation][:schedule_id]
    )
    if @reservation.save
      flash[:success] = "予約が完了しました"
      redirect_to movies_path(@movie)
    else
      flash[:danger] = "その座席はすでに予約済みです"
      redirect_to reservation_movie_path(params[:reservation][:movie_id], schedule_id: @schedule.id, date: params[:reservation][:date])
    end
  end

end
