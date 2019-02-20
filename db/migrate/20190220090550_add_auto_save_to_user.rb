class AddAutoSaveToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :autosave, :boolean, default: false
  end
end
