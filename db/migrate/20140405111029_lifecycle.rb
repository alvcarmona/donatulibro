class Lifecycle < ActiveRecord::Migration
  def self.up
    add_column :libros, :estado, :string
    add_column :libros, :key_timestamp, :datetime

    add_index :libros, [:estado]
  end

  def self.down
    remove_column :libros, :estado
    remove_column :libros, :key_timestamp

    remove_index :libros, :name => :index_libros_on_estado rescue ActiveRecord::StatementInvalid
  end
end
