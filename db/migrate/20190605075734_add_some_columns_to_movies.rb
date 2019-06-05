class AddSomeColumnsToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :movie_name, :string
    add_column :movies, :movie_image_url, :string
  end
end
