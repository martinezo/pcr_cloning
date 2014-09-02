class AddPriceToRequestsCloning < ActiveRecord::Migration
  def change
    add_column :requests_clonings, :price, :decimal, default: 0
  end
end
