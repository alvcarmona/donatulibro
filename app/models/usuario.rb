class Usuario < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    pass      :string
    direccion :string
    puntos    :integer
    mail      :string
    movil     :integer
    nombre    :string
    timestamps
  end
  attr_accessible :pass, :direccion, :puntos, :mail, :movil, :nombre

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
