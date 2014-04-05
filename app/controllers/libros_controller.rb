class LibrosController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def index
    scope = Libro
    if params[:autor]
      scope = Libro.where("autor LIKE ?", "%#{params[:autor]}%").
                    where("titulo LIKE ?", "%#{params[:titulo]}%").
                    where("editorial LIKE ?", "%#{params[:editorial]}%")
    end
    hobo_index scope
  end

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
