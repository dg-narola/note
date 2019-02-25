class RemoveViewFromSharenotes < ActiveRecord::Migration[5.2]
  def change
    remove_column :sharenotes, :view, :boolean
  end
end
