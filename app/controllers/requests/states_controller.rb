class Requests::StatesController < ApplicationController
  before_action :set_requests_state, only: [:show, :edit, :update, :destroy]

  # GET /requests/states
  # GET /requests/states.json
  def index
    @requests_states = Requests::State.all
  end

  # GET /requests/states/1
  # GET /requests/states/1.json
  def show
  end

  # GET /requests/states/new
  def new
    @requests_state = Requests::State.new
  end

  # GET /requests/states/1/edit
  def edit
  end

  # POST /requests/states
  # POST /requests/states.json
  def create
    @requests_state = Requests::State.new(requests_state_params)

    respond_to do |format|
      if @requests_state.save
        format.html { redirect_to @requests_state, notice: 'State was successfully created.' }
        format.json { render action: 'show', status: :created, location: @requests_state }
      else
        format.html { render action: 'new' }
        format.json { render json: @requests_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/states/1
  # PATCH/PUT /requests/states/1.json
  def update
    respond_to do |format|
      if @requests_state.update(requests_state_params)
        format.html { redirect_to @requests_state, notice: 'State was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @requests_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/states/1
  # DELETE /requests/states/1.json
  def destroy
    @requests_state.destroy
    respond_to do |format|
      format.html { redirect_to requests_states_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requests_state
      @requests_state = Requests::State.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requests_state_params
      params.require(:requests_state).permit(:name)
    end
end
