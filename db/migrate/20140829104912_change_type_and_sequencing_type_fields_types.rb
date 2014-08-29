class ChangeTypeAndSequencingTypeFieldsTypes < ActiveRecord::Migration
  def change
    remove_column :requests_clonings, :type
    remove_column :requests_clonings, :sequencing_type
    add_column :requests_clonings, :type, :integer, :default => 1
    add_column :requests_clonings, :sequencing_type, :integer
  end
end
