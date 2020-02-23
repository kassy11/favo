class AddBackgroundColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :back_ground_image, :string
  end
end
