class Admin::ScholarshipsController < ApplicationController
  before_action :authenticate_recruiter, except: [:show]
  before_action :set_scholarship, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column

  # GET /scholarships
  def index
    @scholarships = Scholarship.all
  end

  # GET /scholarships/1
  def show
    @commentable = @scholarship
    @comments = @scholarship.comments.where(original_comment_id: nil).order(created_at: :desc)
    @blank_comment = Comment.new
  end

  # GET /scholarships/new
  def new
    @scholarship = Scholarship.new
  end

  # GET /scholarships/1/edit
  def edit
  end

  # POST /scholarships
  def create
    @scholarship = Scholarship.new(scholarship_params)

    if @scholarship.save
      redirect_to admin_scholarships_path, notice: 'Scholarship was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /scholarships/1
  def update
    if @scholarship.update(scholarship_params)
      redirect_to @scholarship, notice: 'Scholarship was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /scholarships/1
  def destroy
    @scholarship.destroy
    redirect_to admin_scholarships_path, notice: 'Scholarship was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scholarship
      @scholarship = Scholarship.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def scholarship_params
      params.require(:scholarship).permit(:name, :description, :deadline, :amount, :requirements, :full_ride, :link)
    end

    def sort_column
      %w[name amount deadline].include?(params[:sort]) ? params[:sort] : "name"
    end
end
