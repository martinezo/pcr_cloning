class Requests::CloningsController < ApplicationController

  require 'pdf_generator'

  before_action :set_requests_cloning, only: [:show, :edit, :update, :destroy, :delete]
  helper_method :sort_column, :sort_direction

  # GET /requests/clonings
  # GET /requests/clonings.json
  def index
    @requests_clonings = Requests::Cloning.search(params[:search]).order("#{sort_column} #{sort_direction}").paginate(per_page: 15, page:  params[:page])
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
        #Generarte PDF
        filename = "public/pdf/#{'%.6d' % @requests_cloning.id}_pcr.pdf"
        PdfGenerator.request(@requests_cloning, filename)
        format.html { redirect_to @requests_cloning, notice: t('notices.saved_successfully') }
        format.json { render action: 'show',
                             status: :created, location: @requests_cloning }



      else
        format.html { render action: 'new' }
        format.json { render json: @requests_cloning.errors,
                             status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /requests/clonings/1
  # PATCH/PUT /requests/clonings/1.json
  def update
#    @requests_cloning = Requests::Cloning.find(params[:id])

    respond_to do |format|
      if @requests_cloning.update(requests_cloning_params)
        #Generarte PDF
        filename = "public/pdf/#{'%.6d' % @requests_cloning.id}_pcr.pdf"
        PdfGenerator.request(@requests_cloning, filename)
        format.html { redirect_to @requests_cloning, notice: t('notices.updated_successfully') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @requests_cloning.errors, status: :unprocessable_entity }
      end
    end

  end


  def delete

  end

  # DELETE /requests/clonings/1
  # DELETE /requests/clonings/1.json
  def destroy
    @requests_cloning.destroy
    index
  end

  def xlsx_range
    #@requests_cloning = Requests::Cloning.find(1)
  end


  def download_xlsx
    start_date = params['date_range']['start_date'].to_date
    end_date = params['date_range']['end_date'].to_date
    requests_cloning = Requests::Cloning.where(:created_at => start_date.beginning_of_day..end_date.end_of_day)
    generate_xlsx(requests_cloning)
    send_file("#{Rails.root}/public/xlsx/pcr_clonings_requests.xlsx", filename: "clonings_#{Time.now().strftime('%Y%M%d%H%m')}.xlsx", type: "application/vnd.ms-excel")
  end

  def generate_xlsx(requests)
    package = Axlsx::Package.new
    workbook = package.workbook

    workbook.add_worksheet(name: "Clonaciones") do |sheet|
      title = sheet.styles.add_style sz: 16, b: 1
      headers = sheet.styles.add_style sz: 12, alignment: { horizontal: :left }, b: 1, fg_color: '000000', bg_color: "dee1e3"

      # Course name and start date
      sheet.add_row ["#{t("titles.requests_clonings")}"], :style => title, :widths=>[6]
      sheet.add_row


      # Records header
      values = ['No.']
      #requests cloning Headers
      requests.column_names.each do |f|
        case f
          when "id"
          when "created_at"
          when "updated_at"
          else
           values << I18n.t("activerecord.attributes.requests/cloning.#{f.to_s}")
        end
      end
      sheet.add_row values, :style => headers

      #Cloning requests - Detail
      values = nil
      requests.each_with_index  do |r,i|
        values = [i+1]
        r.attributes.each do |f|
          case f[0]
            when "id"
            when "created_at"
            when "updated_at"
            when "req_type"
              values<< Requests::Cloning::TYPE[f[1]]
            when "sequencing_type"
              values << Requests::Cloning::SEQ_TYPE[f[1]]
            when 'payment_method'
              values << Requests::Cloning::PMT_METHOD[f[1]]
            when 'inv_state_id'
              values << r.state.name
            else
              values << f[1]
          end
        end
        sheet.add_row values
      end

     end # end workbook

    package.serialize("public/xlsx/pcr_clonings_requests.xlsx")
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requests_cloning
      @requests_cloning = Requests::Cloning.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requests_cloning_params
      params.require(:requests_cloning).permit(:name, :company, :mail, :phone, :shipping_address, :group_leader,
                                               :payment_method, :sample_name, :sample_volume, :pcr_product_size,
                                               :req_type, :sequencing_type, :inv_name, :inv_rfc, :inv_address, :inv_city,
                                               :inv_municipality, :inv_state_id, :inv_mail)
    end

  def sort_column
    params[:sort] || 'created_at'
  end

  def sort_direction
    params[:direction] || 'asc'
  end

end
