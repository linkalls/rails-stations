class Admin::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.joins(schedule: :movie)
                               .where(movies: { is_showing: true }) # is_showingがtrue(1)らしい
                               .includes(schedule: :movie)

  end
end
