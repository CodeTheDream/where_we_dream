class Admin::SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :edit, :update, :destroy]

  def index
    School.where(name: '').destroy_all
    @schools = School.search(params[:search])
  end

  def show
    unless @school.rules.count == Question.count
      array1 = Question.all.map(&:id)
      array2 = @school.rules.map{|x| x.question.id}
      array1 -= array2
      array1.each do |id|
        @school.rules.create(question_id: id)
      end
    end
  end

  def new
    @school = School.create(name: "")
    Question.all.each do |question|
      @school.rules.create(question: question)
    end
  end

  def edit
  end

  def create
    @school = School.create(new_school_params)
    p "nigga we made it"
    p "params = #{params}"
    if @school.update(school_params)
      redirect_to admin_schools_path, notice: 'School was successfully created.'
    else
      p "nope didn't make it :("
      School.destroy(@school.id)
      redirect_to admin_schools_path
    end
  end

  def update
    if @school.update(school_params)
      redirect_to admin_schools_path, notice: 'School was successfully updated.'
    else
      render :edit
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

    def new_school_params
      params.require(:school).permit(
        :name, :link, :rating, :students, :undocumented_students, :street, :city,
        :state, :zip, :public
      )
    end

    def school_params
      params.require(:school).permit(
        :name, :link, :rating, :students, :undocumented_students, :street, :city,
        :state, :zip, :public, rules_attributes: [:id, :answer]
      )
    end
end
