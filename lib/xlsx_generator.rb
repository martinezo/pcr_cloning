class XlsxGenerator
  def self.generate_xlsx(requests, start_date, end_date, columns)
        package = Axlsx::Package.new
    workbook = package.workbook

    workbook.add_worksheet(name: "Clonaciones") do |sheet|
      title = sheet.styles.add_style sz: 16, b: 1
      headers = sheet.styles.add_style sz: 12, alignment: { horizontal: :left }, b: 1, fg_color: '000000', bg_color: "dee1e3"

      # Course name and start date
      sheet.add_row ["#{I18n.t("titles.requests_clonings")} (#{start_date} -  #{end_date})"], :style => title, :widths=>[6]
      sheet.add_row

      # Records header
      values = ['No.']
      columns.split(',').each do |c|
        values << I18n.t("activerecord.attributes.requests/cloning.#{c.strip}")
      end
      #requests cloning Headers
      #requests.column_names.each do |f|
      #  case f
      #    when "id"
      #    when "created_at"
      #    when "updated_at"
      #    else
      #     values << I18n.t("activerecord.attributes.requests/cloning.#{f.to_s}")
      #  end
      #end
      sheet.add_row values, :style => headers

      #Cloning requests - Detail
      values = nil
      requests.each_with_index  do |r,i|
        values = [i+1]
        r.attributes.each do |f|
          case f[0]
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
end