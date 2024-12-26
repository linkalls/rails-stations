class Admin::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.joins(schedule: :movie)
                               .where(movies: { is_showing: true }) # is_showingがtrue(1)らしい
                               .includes(schedule: :movie)
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(post_params)
    if @reservation.save
      flash[:success] = "予約に成功しました"
      redirect_to admin_reservations_path
    else
      flash[:danger] = "予約に失敗しました"
      render "new", status: 400
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(post_params)
      flash[:success] = "予約を更新しました"
      redirect_to admin_reservations_path
    else
      flash[:danger] = "予約を更新できません"
      render "edit", status: 400
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      flash[:success] = "予約を削除しました"
      redirect_to admin_reservations_path
    else
      flash[:danger] = "予約を削除できません"
      render "edit", status: 400
    end
  end

  private

  def post_params
    params.require(:reservation).permit(:name, :email, :date, :sheet_id, :schedule_id)
  end
end
