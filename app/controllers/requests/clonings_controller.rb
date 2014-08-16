class Requests::CloningsController < ApplicationController
  before_action :set_requests_cloning, only: [:show, :edit, :update, :destroy]

  # GET /requests/clonings
  # GET /requests/clonings.json
  def index
    @requests_clonings = Requests::Cloning.all
  end

  # GET /requests/clonings/1
  # GET /requests/clonings/1.json
  def show
  end

  # GET /requests/clonings/new
  def new
    @requests_cloning = Requests::Cloning.new
  end

  # GET /requests/clonings/1/edit
  def edit
  end

  # POST /requests/clonings
  # POST /requests/clonings.json
  def create
    @requests_cloning = Requests::Cloning.new(requests_cloning_params)

    respond_to do |format|
      if @requests_cloning.save
        format.html { redirect_to @requests_cloning, notice: 'Cloning was successfully created.' }
        format.json { render action: 'show', status: :created, location: @requests_cloning }
      else
        format.html { render action: 'new' }
        format.json { render json: @requests_cloning.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/clonings/1
  # PATCH/PUT /requests/clonings/1.json
  def update
    respond_to do |format|
      if @requests_cloning.update(requests_cloning_params)
        format.html { redirect_to @requests_cloning, notice: 'Cloning was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @requests_cloning.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/clonings/1
  # DELETE /requests/clonings/1.json
  def destroy
    @requests_cloning.destroy
    respond_to do |format|
      format.html { redirect_to requests_clonings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requests_cloning
      @requests_cloning = Requests::Cloning.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requests_cloning_params
      params.require(:requests_cloning).permit(:name, :company, :mail, :phone, :shipping_address, :group_leader, :payment_method, :sample_name, :sample_volume, :pcr_product_size, :type, :sequencing_type, :inv_name, :inv_rfc, :inv_address, :inv_city, :inv_municipality, :inv_mail)
    end
end
