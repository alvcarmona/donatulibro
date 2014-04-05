class Libro < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    autor       :string, :required
    editorial   :string
    titulo      :string, :required, :name => true
    curso       :string
    edicion     :string
    descripcion :string
    timestamps
  end
  
  belongs_to :user
  belongs_to :reservador, :class_name => "User" , :creator => true
 										
  attr_accessible :autor, :editorial, :titulo, :curso, :edicion, :descripcion


  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up?
  end

  def update_permitted?
    acting_user.administrator? ||  (acting_user.signed_up? &&  acting_user==user)
  end

  def destroy_permitted?
    acting_user.administrator? ||  (acting_user.signed_up? &&  acting_user==user)
  end

  def view_permitted?(field)
    true
  end

end 
