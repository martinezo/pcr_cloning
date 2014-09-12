class Public::PcrCloningRequestsController < ApplicationController

  require 'pdf_generator'

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
        #Send mails
        PcrCloningMailer.user_notification(@requests_cloning, filename).deliver unless @requests_cloning.mail.strip.empty?
        PcrCloningMailer.admin_notification(@requests_cloning, filename).deliver
        PcrCloningMailer.deposit_notification(@requests_cloning, filename).deliver unless @requests_cloning.payment_method < 4 #Deposit or cash
        format.html { redirect_to public_pcr_cloning_requests_sent_path, flash: {request_folio: @requests_cloning.folio}}
      else
        format.html { render action: 'new' }
        format.json { render json: @requests_cloning.errors, status: :unprocessable_entity }
      end
    end
  end

  def sent
    @folio=flash[:request_folio]
  end

  def pdf_req_download
    @requests_cloning = Requests::Cloning.find_by_folio(params[:folio])
    filename= "#{'%.6d' % @requests_cloning.id}_pcr.pdf"
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
