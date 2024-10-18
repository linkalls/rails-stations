class SheetsController < ApplicationController
  def index
    @sheets = Sheet.all.order(:row, :column)
    @rows = @sheets.pluck(:row).uniq
    @columns = @sheets.pluck(:column).uniq
  end
end
