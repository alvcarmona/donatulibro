class HoboMigration1 < ActiveRecord::Migration
  def self.up
    add_column :libros, :reservador_id, :integer

    add_index :libros, [:reservador_id]
  end

  def self.down
    remove_column :libros, :reservador_id

    remove_index :libros, :name => :index_libros_on_reservador_id rescue ActiveRecord::StatementInvalid
  end
end
