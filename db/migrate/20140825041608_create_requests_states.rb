class CreateRequestsStates < ActiveRecord::Migration
  def change
    create_table :requests_states do |t|
      t.string :name

      t.timestamps
    end
  end
end
