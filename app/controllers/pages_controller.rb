class PagesController < ApplicationController
  def home
    @page = "home"
  end

  def schools
    @schools = School.search(params[:search]).order(sort_column + " " + sort_direction)
  end
end
