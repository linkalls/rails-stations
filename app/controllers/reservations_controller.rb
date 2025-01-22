class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def new
    # render json: { params: params }
    # 必要なパラメータが欠けている場合はリダイレクト
    return redirect_to movies_path if params[:movie_id].blank? || params[:sheet_id].blank? || params[:date].blank?

    @reservation = Reservation.new(
      schedule_id: params[:schedule_id],
      date: params[:date], # dataパラメーターの対応
      sheet_id: params[:sheet_id],
      user: current_user
    )
    @schedule = Schedule.find(params[:schedule_id])
  end

  def create
    # @movie = Movie.find(params[:movie_id])
    # @schedule = @movie.schedules.find(params[:schedule_id])
    @user = User.find(params[:reservation][:user_id])
    @schedule = Schedule.find(params[:reservation][:schedule_id])
    @reservation = @schedule.reservations.new(
      date: params[:reservation][:data] || params[:reservation][:date], # dataパラメーターの対応
      sheet_id: params[:reservation][:sheet_id],
      schedule_id: params[:reservation][:schedule_id],
      user: current_user || @user
    )
    render json: { reservation: @reservation }
    # if @reservation.save
    #   flash[:success] = '予約が完了しました'
    #   redirect_to movies_path(@movie)
    # else
    #   flash[:danger] = 'その座席はすでに予約済みです'
    #   redirect_to reservation_movie_path(params[:reservation][:movie_id], schedule_id: @schedule.id,
    #                                                                       date: params[:reservation][:date])
    # end
  end
end
