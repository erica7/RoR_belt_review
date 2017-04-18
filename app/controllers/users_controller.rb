class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new]

  def new
    if session[:user_id]
      redirect_to '/events'
    end
    @states = State.all
  end

  def create
    user = User.new(register_params.merge(state: State.find(register_params[:state])))
    if user.save
      session[:user_id] = user.id
      redirect_to '/events'
    else
      flash[:errors] = user.errors.full_messages
      redirect_to '/'
    end
  end

  def edit
    @states = State.all
    @this_user = current_user
    # render :edit
  end

  def update
    user = current_user
    if not user.update(edit_params.merge(state: State.find(edit_params[:state])))
      flash[:errors] = user.errors.full_messages
    end
    redirect_to "/events"
  end


  private
    def register_params
      params.require(:register).permit(:first_name, :last_name, :email, :city, :state, :password, :password_confirmation)
    end

    def edit_params
      params.require(:edit).permit(:first_name, :last_name, :email, :city, :state)
    end
end
