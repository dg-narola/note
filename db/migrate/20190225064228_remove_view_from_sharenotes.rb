# frozen_string_literal: true

# removed view from sharenotes for making changes
class RemoveViewFromSharenotes < ActiveRecord::Migration[5.2]
  def change
    remove_column :sharenotes, :view, :boolean
  end
end
