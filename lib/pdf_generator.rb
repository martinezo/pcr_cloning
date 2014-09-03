class PdfGenerator

  require 'prawn'
  require 'prawn/table'
  require 'prawn/measurement_extensions'

  def self.request(r, filename)
    Prawn::Document.generate(filename, left_margin: 1.in) do
      img = 'public/pdf/assets/pdf_header.jpg'
      table [[{image: img, fit: [500, 200]}]], position: :center, cell_style: {background_color: '#ffff', padding: 0, border_width: 0}

      # TABLE FORMAT
      c_style = {height: (0.25).in, size: 10, border_color: '3A2A1A', border_width: 0.5, valign: :middle}
      c_style_h = {background_color: 'FFAD4D', align: :right, font_style: :bold_italic, padding:[3,10,0,0] }
      c_style_d = { padding: 3}
      alt_1, alt_2= 'FFEECC','FFFCF5'

      move_down (0.25).in

      # REGISTRATION DATE
      headers = [[I18n.t('titles.req_date')]]
      data = [[I18n.localize(r.created_at, :format => :long_only_date)]]
      col_1 = make_table headers, column_widths: 2.in, cell_style: c_style.merge(c_style_h)
      col_2 = make_table data, column_widths: 2.in, cell_style: c_style.merge(c_style_d)
      table [[col_1, col_2]], position: :right

      move_down (0.25).in

      # USER DATA
      pad(10) { text I18n.t('titles.user_data'), style: :bold, size: 12 }

      t = 'activerecord.attributes.requests/cloning.'

      headers = [[I18n.t("#{t}name")], [I18n.t("#{t}company")], [I18n.t("#{t}mail")], [I18n.t("#{t}phone")], [I18n.t("#{t}shipping_address")], [I18n.t("#{t}group_leader")]]
      data = [[r.name], [r.company], [r.mail], [r.phone],[r.shipping_address],[r.group_leader]]
      col_1 = make_table headers, column_widths: 2.in, cell_style: c_style.merge(c_style_h)
      col_2 = make_table data, column_widths: 5.in, row_colors: [alt_1, alt_2], cell_style: c_style.merge(c_style_d)
      table [[col_1, col_2]]

      move_down (0.125).in

      # SAMPLE DATA
      pad(10) { text I18n.t('titles.sample_data'), style: :bold, size: 12 }

      headers = [[I18n.t("#{t}sample_name")], [I18n.t("#{t}sample_volume")], [I18n.t("#{t}pcr_product_size")], [I18n.t("#{t}req_type")], r.req_type==1 ? [] :[I18n.t("#{t}sequencing_type")]]
      data = [[r.sample_name], [r.sample_volume], [r.pcr_product_size], [Requests::Cloning::TYPE[r.req_type]],r.req_type == 1 ? [] :[Requests::Cloning::SEQ_TYPE[r.sequencing_type]]]
      col_1 = make_table headers, column_widths: 2.25.in, cell_style: c_style.merge(c_style_h)
      col_2 = make_table data, column_widths: 4.75.in, row_colors: [alt_1, alt_2], cell_style: c_style.merge(c_style_d)
      table [[col_1, col_2]]

      move_down (0.125).in

      # INVOICE DATA
      pad(10) { text I18n.t('titles.invoice_data'), style: :bold, size: 12 }

      headers = [[I18n.t("#{t}payment_method")],[I18n.t("#{t}inv_name")], [I18n.t("#{t}inv_rfc")], [I18n.t("#{t}inv_address")], [I18n.t("#{t}inv_municipality")], [I18n.t("#{t}inv_estate")],[I18n.t("#{t}inv_mail")]]
      data = [[Requests::Cloning::PMT_METHOD[r.payment_method]],[r.inv_name], [r.inv_rfc], [r.inv_address], [r.inv_municipality],[r.state.name],[r.inv_mail]]
      col_1 = make_table headers, column_widths: 2.25.in, cell_style: c_style.merge(c_style_h)
      col_2 = make_table data, column_widths: 4.75.in, row_colors: [alt_1, alt_2], cell_style: c_style.merge(c_style_d)
      table [[col_1, col_2]]

      move_down (0.125).in

      # PRICE
      headers = [[I18n.t('titles.price')]]
      data = [["$ #{'%.2f' % r.price}"]]
      col_1 = make_table headers, column_widths: 1.in, cell_style: c_style.merge(c_style_h)
      col_2 = make_table data, column_widths: 1.in, cell_style: c_style.merge(c_style_d)
      table [[col_1, col_2]], position: :right

    end
  end

end