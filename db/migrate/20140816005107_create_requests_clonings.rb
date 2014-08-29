class CreateRequestsClonings < ActiveRecord::Migration
  def change
    create_table :requests_clonings do |t|
      t.string :name
      t.string :company
      t.string :mail
      t.string :phone
      t.string :shipping_address
      t.string :group_leader
      t.integer :payment_method, :default => 1
      t.string :sample_name
      t.string :sample_volume
      t.string :pcr_product_size
      t.integer :type, :default => 1
      t.integer :sequencing_type
      t.string :inv_name
      t.string :inv_rfc
      t.string :inv_address
      t.integer :inv_state_id
      t.string :inv_municipality
      t.string :inv_mail

      t.timestamps
    end
  end
end
