class AddImpToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :important, :boolean, default: false
  end
end
