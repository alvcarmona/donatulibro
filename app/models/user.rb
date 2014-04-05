class User < ActiveRecord::Base

  hobo_user_model # Don't put anything above this

  fields do
    name          :string, :required, :unique
    email_address :email_address, :login => true
    administrator :boolean, :default => false
    direccion     :string #:required
    movil         :string #:required
    puntos        :integer
    
    timestamps
  end
  has_many :libros
  has_many :libros_reservados, :class_name => "Libro", :foreign_key => :reservador_id
  attr_accessible :name, :email_address, :password, :password_confirmation, :current_password, :libro, :movil, :puntos , :direccion

  # This gives admin rights and an :active state to the first sign-up.
  # Just remove it if you don't want that
  before_create do |user|
    if !Rails.env.test? && user.class.count == 0
      user.administrator = true
      user.state = "active"
    end
  end


  # --- Signup lifecycle --- #

  lifecycle do

    state :inactive, :default => true
    state :active

    create :signup, :available_to => "Guest",
      :params => [:name, :email_address, :password, :password_confirmation, :movil, :direccion],
      :become => :inactive, :new_key => true  do
      UserMailer.activation(self, lifecycle.key).deliver
    end

    transition :activate, { :inactive => :active }, :available_to => :key_holder

    transition :request_password_reset, { :inactive => :inactive }, :new_key => true do
      UserMailer.activation(self, lifecycle.key).deliver
    end

    transition :request_password_reset, { :active => :active }, :new_key => true do
      UserMailer.forgot_password(self, lifecycle.key).deliver
    end

    transition :reset_password, { :active => :active }, :available_to => :key_holder,
               :params => [ :password, :password_confirmation ]

  end

  def signed_up?
    state=="active"
  end

  # --- Permissions --- #

  def create_permitted?
    # Only the initial admin user can be created
    self.class.count == 0
  end

  def update_permitted?
    acting_user.administrator? ||
      (acting_user == self && only_changed?(:email_address, :crypted_password,
                                            :current_password, :password, :password_confirmation))
    # Note: crypted_password has attr_protected so although it is permitted to change, it cannot be changed
    # directly from a form submission.
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end
end
