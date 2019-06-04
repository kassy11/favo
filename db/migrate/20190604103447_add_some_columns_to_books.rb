class AddSomeColumnsToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :book_name, :string
    add_column :books, :book_image, :
  end
end
