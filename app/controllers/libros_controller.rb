class LibrosController < ApplicationController

  hobo_model_controller


  auto_actions :all

def create
  @libro = Libro.new(params[:libro])
  @libro.user_id = current_user.id
  if @libro.save

    redirect_to @libro
  else
    render 'new'
  end
end

end
