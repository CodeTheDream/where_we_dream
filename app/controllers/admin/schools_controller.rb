class Admin::SchoolsController < ApplicationController
  before_action :authenticate_admin
  before_action :set_school, only: [:show, :edit, :update, :destroy]
  before_action :set_states, only: [:new, :edit]
  helper_method :sort_column

  def index
    School.where(name: nil).destroy_all
    @schools = School.search(params[:search]).order(sort_column + " " + sort_direction)
  end

  def show
    @commentable = @school
    @comments = @school.comments
    @comment = Comment.new
  end

  def new
    @school = School.create
    Question.all.each do |question|
      @school.rules.create(question: question)
    end
  end

  def edit
  end

  def create
    @school = School.create(new_school_params)
    if @school.update(school_params)
      @school.update(rating: @school.rating!, complete: @school.complete?)
      redirect_to admin_schools_path, notice: 'School was successfully created.'
    else
      School.destroy(@school.id)
      redirect_to admin_schools_path
    end
  end

  def update
    if @school.update(school_params)
      @school.update(rating: @school.rating!, complete: @school.complete?)
      redirect_to admin_schools_path, notice: 'School was successfully updated.'
    else
      redirect_to edit_admin_school_path(@school), notice: 'Update failed'
    end
  end

  def destroy
    @school.destroy
    redirect_to admin_schools_path, notice: 'School was successfully destroyed.'
  end

  private
    def set_school
      @school = School.find(params[:id])
    end

    def set_states
      @states = School.states
    end

    def new_school_params
      params.require(:school).permit(
        :name, :link, :rating, :students, :undocumented_students, :street, :city,
        :state, :zip, :public
      )
    end

    def school_params
      params.require(:school).permit(
        :name, :link, :rating, :students, :undocumented_students, :street, :city,
        :state, :zip, :public, rules_attributes: [:id, :answer, :details]
      )
    end

    def sort_column
      %w[name rating public city complete].include?(params[:sort]) ? params[:sort] : "name"
    end
end
