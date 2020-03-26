# frozen_string_literal: true

class AddBackgroundColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :back_ground_image, :string
  end
end
