class PagesController < ApplicationController
  helper_method :sort_column, :sort_direction
  def home
    @page = "home"
  end

  def schools
    @schools = School.search(params[:search]).order(sort_column + " " + sort_direction)
  end

  private

  def sort_column
    %w[name rating public city].include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
