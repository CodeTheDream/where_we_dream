class SchoolsController < ApplicationController
  before_action :authenticate_admin, only: [:new, :create, :update, :destroy]
  before_action :set_school, only: [:update, :destroy]
  before_action :set_states, only: [:new, :edit]
  helper_method :sort_column

  # 32 queries -> 3 -> 2
  def index
    @schools = School.search(params[:search])
                     .includes(:opinions)
                     .order("#{sort_column} #{sort_direction}")
                     .page(params[:page])
  end

  # 28 queries -> 23 -> 21 -> 19 -> 18 -> 16 -> 13 -> 12 -> 11 -> 7 -> 6
  def show
    @school = School.includes(:comments, :opinions, rules: :question)
                    .find(params[:id])
    @commentable = @school
    @comments = @school.comments.select { |x| x.original_comment_id.nil? }
                       .sort_by(&:created_at)
    @blank_comment = Comment.new
  end

  def new
    @school = School.new
    Question.all.each do |question|
      @school.rules.build(question: question)
    end
  end

  # 9 queries -> 4 -> 3
  def edit
    @school = School.includes(rules: :question).find(params[:id])
  end

  def create
    @school = School.new school_params

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
      %w[name rating city complete].include?(params[:sort]) ? params[:sort] : 'name'
    end
end
