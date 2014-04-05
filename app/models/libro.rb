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
  belongs_to :user , :creator => true
  belongs_to :reservador, :class_name => "User"
 										
  attr_accessible :autor, :editorial, :titulo, :curso, :edicion, :descripcion
before_create :puntos_para_usuario

 def  puntos_para_usuario
      self.user.update_attribute(:puntos,self.user.puntos+2)
 end

  lifecycle :state_field => "estado" do

    state :disponible, :default => true
    state :solicitado, :entregado, :recibido

    transition :solicitar, { :disponible => :solicitado}, :available_to => :all do
      self.update_attribute(:reservador, acting_user)
    end

    transition :enviar, {:solicitado => :entregado}, :available_to => :user do
      reservador.update_attribute(:puntos, reservador.puntos - 3)
    end

    transition :confirmar, { :entregado=> :recibido}, :available_to => :reservador do
      user.update_attribute(:puntos, user.puntos + 3)
    end
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.signed_up?
  end

  def update_permitted?
    # acting_user.administrator? ||  (acting_user.signed_up? &&  acting_user==user)
    true
  end

  def destroy_permitted?
    acting_user.administrator? ||  (acting_user.signed_up? &&  acting_user==user)
  end

  def view_permitted?(field)
    true
  end

end 
