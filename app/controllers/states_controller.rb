class StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]

  # GET /states
  def index
    @states = State.all.order(name: :asc)
  end

  # GET /states/1
  def show
    @schools = @state.schools
  end

  # GET /states/new
  def new
    @state = State.new
  end

  # GET /states/1/edit
  def edit
  end

  # POST /states
  def create
    params[:state][:abbreviation] = params[:state][:name].abbreviate

    @state = State.new state_params

    if @state.save
      redirect_to state_path(@state), notice: 'State added'
    else
      render :new
    end
  end

  # PATCH/PUT /states/1
  def update
    if @state.update state_params
      redirect_to state_path(@state), notice: 'State updated'
    else
      render :edit
    end
  end

  # DELETE /states/1
  def destroy
    @state.destroy
    redirect_to states_path, notice: 'State deleted'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def state_params
      params.require(:state).permit(:name, :abbreviation, :in_state, :description)
    end
end
