class AddCustomerIdToNote < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :customer_id, :integer
  end
end
