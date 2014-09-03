class Public::PcrCloningRequestsController < ApplicationController
  def new
    @requests_cloning = Requests::Cloning.new
  end

  def create
    @requests_cloning = Requests::Cloning.new(requests_cloning_params)

    respond_to do |format|
      if @requests_cloning.save
        #Generarte PDF
        filename = "public/pdf/#{'%.6d' % @requests_cloning.id}_pcr.pdf"
        PdfGenerator.request(@requests_cloning, filename)
        format.html { redirect_to public_pcr_cloning_requests_sent_path, flash: {request_id: @requests_cloning.id}}
      else
        format.html { render action: 'new' }
        format.json { render json: @requests_cloning.errors, status: :unprocessable_entity }
      end
    end
  end

  def sent
    @id=flash[:request_id]
  end

  def pdf_req_download
    filename= "#{'%.6d' % params[:id].to_i}_pcr.pdf"
    file = "public/pdf/#{filename}"
    send_file  file, filename: filename, type: "application/pdf"
  end

  private

      # Never trust parameters from the scary internet, only allow the white list through.
      def requests_cloning_params
        params.require(:requests_cloning).permit(:name, :company, :mail, :phone, :shipping_address, :group_leader,
                                                 :payment_method, :sample_name, :sample_volume, :pcr_product_size,
                                                 :req_type, :sequencing_type, :inv_name, :inv_rfc, :inv_address, :inv_city,
                                                 :inv_municipality, :inv_state_id, :inv_mail)
      end
end
