class AddSomeColumnsToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :book_name, :string
    add_column :books, :book_image_url, :string
  end
end
