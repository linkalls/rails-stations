class Admin::ReservationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @reservations = Reservation.joins(schedule: :movie)
                               .where(movies: { is_showing: true }) # is_showingがtrue(1)らしい
                               .includes(:user, schedule: :movie)
  end

  def new
    @reservation = Reservation.new
  end

  def create
    # @schedule = Schedule.find(params[:reservation][:schedule_id])
    # @reservation = Reservation.new(post_params)
    # @reservation.schedule = @schedule
    # @reservation.user = current_user
    # # dataパラメーターをdateに変換
    # if @reservation.save
    #   flash[:success] = '予約に成功しました'
    #   redirect_to admin_reservations_path
    # else
    #   flash[:danger] = '予約に失敗しました'
    #   render 'new', status: 400
    # end
    @schedule = Schedule.find(params[:reservation][:schedule_id])
    @reservation = @schedule.reservations.new(
      date: params[:reservation][:data] || params[:reservation][:date], # dataパラメーターの対応
      sheet_id: params[:reservation][:sheet_id],
      schedule_id: params[:reservation][:schedule_id],
      user: current_user
    )
    if @reservation.save
      flash[:success] = '予約が完了しました'
      redirect_to movies_path(@movie)
    else
      flash[:danger] = 'その座席はすでに予約済みです'
      redirect_to reservation_movie_path(params[:reservation][:movie_id], schedule_id: @schedule.id,
                                         date: params[:reservation][:date])
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(post_params)
      flash[:success] = '予約を更新しました'
      redirect_to admin_reservations_path
    else
      flash[:danger] = '予約を更新できません'
      render 'edit', status: 400
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      flash[:success] = '予約を削除しました'
      redirect_to admin_reservations_path
    else
      flash[:danger] = '予約を削除できません'
      render 'edit', status: 400
    end
  end

  private

  def post_params
    params.require(:reservation).permit(:date, :sheet_id, :schedule_id)
  end
end
