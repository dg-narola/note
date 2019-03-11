class AddPriceToNote < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :price, :decimal, default: 100
  end
end
