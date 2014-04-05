class DonarlibrosMigration1 < ActiveRecord::Migration
  def self.up
    create_table :usuarios do |t|
      t.string   :pass
      t.string   :direccion
      t.integer  :puntos
      t.string   :mail
      t.integer  :movil
      t.string   :nombre
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :libros do |t|
      t.string   :autor
      t.string   :editorial
      t.string   :titulo
      t.string   :curso
      t.string   :edicion
      t.string   :descripcion
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
    end
    add_index :libros, [:user_id]

    add_column :users, :direccion, :string
    add_column :users, :movil, :string
    add_column :users, :puntos, :integer
  end

  def self.down
    remove_column :users, :direccion
    remove_column :users, :movil
    remove_column :users, :puntos

    drop_table :usuarios
    drop_table :libros
  end
end
