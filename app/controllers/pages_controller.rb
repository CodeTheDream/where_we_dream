class PagesController < ApplicationController
  def home
    @schools = School.search(params[:search])
  end

  def schools
  end
end
