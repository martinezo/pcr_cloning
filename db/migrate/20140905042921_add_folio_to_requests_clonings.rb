class AddFolioToRequestsClonings < ActiveRecord::Migration
  def change
    add_column :requests_clonings, :folio, :integer
  end
end
