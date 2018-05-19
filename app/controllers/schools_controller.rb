class SchoolsController < ApplicationController
  before_action :authenticate_admin, except: [:show, :update]
  before_action :set_school, only: [:show, :edit, :update, :destroy]
  before_action :set_states, only: [:new, :edit]
  helper_method :sort_column

  def index
    School.where(name: nil).destroy_all
    @schools = School.search(params[:search])
                     .order("#{sort_column} #{sort_direction}")
                     .page(params[:page])
  end

  def show
    @commentable = @school
    @comments = @school.comments.where(original_comment_id: nil).order(created_at: :desc)
    @blank_comment = Comment.new
  end

  def new
    # this was needed before because we used
    # School.where(name: nil).destroy_all
    @school = School.new
    Question.all.each do |question|
      @school.rules.build(question: question)
    end
  end

  def edit
  end

  # this controller action has never been run. You go from the :new view to the :create action because this new view :creates a school.
  def create
    @school = School.new(school_params)
    if @school.save
      @school.update complete: @school.complete?
      redirect_to schools_path, notice: 'School successfully added'
    else
      redirect_to schools_path
    end
  end

  def update
    if @school.update(school_params)
      @school.update(complete: @school.complete?)
      redirect_to school_path(@school), notice: 'School successfully updated'
    else
      redirect_to edit_school_path(@school), notice: 'Update failed'
    end
  end

  def destroy
    @school.destroy
    redirect_to schools_path, notice: 'School successfully deleted'
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
        :state, :zip, :public, :description, rules_attributes: [:id, :question_id, :answer, :details]
      )
    end

    private

    def sort_column
      %w[name rating city complete].include?(params[:sort]) ? params[:sort] : "name"
    end
end
