class Admin::QuestionsController < ApplicationController
  before_action :authenticate_admin
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET admin/questions
  def index
    @questions = Question.all
    @question = Question.new
  end

  # GET admin/questions/new
  def new
    @question = Question.new
  end

  # POST admin/questions
  def create
    @question = Question.new(question_params)
    if @question.value.blank?
      @questions = Question.all
    elsif @question.save
      School.all.each do |school|
        school.rules.create(question: @question)
      end
      @questions = Question.all
    end
  end

  # PATCH/PUT admin/questions/1
  def update
    if @question.update(question_params)
      render nothing: true
    else
      render :edit
    end
  end

  # DELETE admin/questions/1
  def destroy
    @question.destroy
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      params.require(:question).permit(:rule_id, :value)
    end
end
