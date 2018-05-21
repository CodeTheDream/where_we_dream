class ScholarshipsController < ApplicationController
  before_action :authenticate_recruiter, except: [:show]
  before_action :set_scholarship, only: [:edit, :update, :destroy]
  helper_method :sort_column

  # GET /scholarships
  # 1 query
  def index
    @scholarships = Scholarship.search(params[:search])
                               .order("#{sort_column} #{sort_direction}")
                               .page(params[:page])
  end

  # GET /scholarships/1
  # 6 queries -< 5 -> 4
  def show
    @scholarship = Scholarship.includes(:comments).find(params[:id])
    @commentable = @scholarship
    @comments = @scholarship.comments.select { |x| x.original_comment_id.nil? }
                            .sort_by(&:created_at)
    @blank_comment = Comment.new
  end

  # GET /scholarships/new
  def new
    @scholarship = Scholarship.new
  end

  # GET /scholarships/1/edit
  # 1 query
  def edit
  end

  # POST /scholarships
  def create
    @scholarship = Scholarship.new scholarship_params

    if @scholarship.save
      redirect_to scholarship_path(@scholarship), notice: "<a href='#{scholarship_path(@scholarship)}'>Scholarship</a> added"
    else
      render :new
    end
  end

  # PATCH/PUT /scholarships/1
  def update
    if @scholarship.update scholarship_params
      redirect_to scholarship_path(@scholarship), notice: "<a href='#{scholarship_path(@scholarship)}'>Scholarship</a> updated"
    else
      render :edit
    end
  end

  # DELETE /scholarships/1
  def destroy
    @scholarship.destroy
    redirect_to scholarships_path, notice: 'Scholarship deleted'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scholarship
      @scholarship = Scholarship.find params[:id]
    end

    # Only allow a trusted parameter "white list" through.
    def scholarship_params
      params.require(:scholarship).permit(:name, :description, :deadline, :amount, :requirements, :full_ride, :link)
    end

    def sort_column
      %w[name amount deadline].include?(params[:sort]) ? params[:sort] : 'name'
    end
end
