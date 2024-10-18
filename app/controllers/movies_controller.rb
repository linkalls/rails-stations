class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    # return render json: params
    if params.present? # あるかどうか
      if params[:is_showing] == 1
        @movies = @movies.where(is_showing: true)
      elsif params[:is_showing] == 0
        @movies = @movies.where(is_showing: false)
      end
      if params[:keyword].present?
        @movies = @movies.where("name LIKE ? OR description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%") # 検索
        # 名前か説明に入ってたら
      end
      respond_to do |format|
        format.html # 普通にhtml返す
        format.turbo_stream { render partial: "movies_list" } # turbo返すときにこれ使う
      end
    end
  end
end


