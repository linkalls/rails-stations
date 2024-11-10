class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    # return render json: params
    if params.present? # あるかどうか
      if params[:is_showing] == "1"
        @movies = @movies.where(is_showing: true)
      elsif params[:is_showing] == "0"
        @movies = @movies.where(is_showing: false)
      end
      if params[:keyword].present?
        @movies = @movies.where("name LIKE ? OR description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%") # 検索
        # 名前か説明に入ってたら
      end

    end
  end

  def show
    @movie = Movie.find(params[:id])
    # assigns(:schedules)ってテストの書いてあるからこれかく
    @schedules = @movie.schedules
  end

  # def reservation
  #   @movie = Movie.find(params[:id])

  #   # schedule_idがない場合は302リダイレクト
  #   if params[:schedule_id].blank?
  #     redirect_to movies_path, alert: 'スケジュールIDが必要です。'
  #     return
  #   end

  #   # dateがない場合も同様にリダイレクト
  #   if params[:date].blank?
  #     redirect_to movies_path, alert: '日付が必要です。'
  #     return
  #   end

  #   @schedule = Schedule.find(params[:schedule_id])
  #   @sheets = Sheet.all.order(:row, :column)
  #   @rows = @sheets.pluck(:row).uniq
  #   @columns = @sheets.pluck(:column).uniq
  #   @reservation_sheets = Reservation.where(schedule_id: params[:schedule_id], date: params[:date]).pluck(:sheet_id)
  #   # これで登録されてるもの全部のsheet_idを配列で見れる
  # end

  def reservation
    @movie = Movie.includes(:schedules).find(params[:id])
    # Movieとその関連するScheduleを一度に読み込み

    # schedule_idがない場合は302リダイレクト
    if params[:schedule_id].blank?
      redirect_to movies_path, alert: 'スケジュールIDが必要です。'
      return
    end

    # dateがない場合も同様にリダイレクト
    if params[:date].blank?
      redirect_to movies_path, alert: '日付が必要です。'
      return
    end

    @schedule = @movie.schedules.find(params[:schedule_id])
    @sheets = Sheet.all.order(:row, :column)
    @rows = @sheets.pluck(:row).uniq
    @columns = @sheets.pluck(:column).uniq
    @reservation_sheets = Reservation.where(schedule_id: params[:schedule_id], date: params[:date]).pluck(:sheet_id)
    # これで登録されてるもの全部のsheet_idを配列で見れる
  end

end
