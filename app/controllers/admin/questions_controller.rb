class Admin::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  def index
    @questions = Question.all
  end

  # GET /questions/1
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  def partial
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    if @question.value.blank?
      @questions = Question.all
    elsif @question.save
      School.all.each{ |school| school.rules.create(question: @question) }
      @questions = Question.all
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      render nothing: true
    else
      render :edit
    end
  end

  # DELETE /questions/1
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
