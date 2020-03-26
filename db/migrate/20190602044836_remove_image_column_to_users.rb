# frozen_string_literal: true

class RemoveImageColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :image, :string
  end
end
