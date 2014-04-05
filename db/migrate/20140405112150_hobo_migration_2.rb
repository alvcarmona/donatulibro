class HoboMigration2 < ActiveRecord::Migration
  def self.up
    change_column :libros, :estado, :string, :limit => 255, :default => "disponible"

    change_column :users, :state, :string, :limit => 255, :default => "active"
  end

  def self.down
    change_column :libros, :estado, :string

    change_column :users, :state, :string, default: "inactive"
  end
end
