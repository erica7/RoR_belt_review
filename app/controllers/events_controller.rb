class EventsController < ApplicationController
  def index
    @events_in_state = Event.where(state: current_user.state).includes(:state, :user)
    @events_out_state = Event.where.not(state: current_user.state).includes(:state, :user)
    @states = State.all
  end

  # def new
  #   # on the 'events#index' page
  # end

  def create
    event = Event.new(event_params.merge(state: State.find(event_params[:state])).merge(user: User.find(session[:user_id])))
    if not event.save
      flash[:errors] = event.errors.full_messages
    end
    redirect_to '/events'
  end

  def show
    @event = Event.find(params[:id])
    @comments = Comment.where(event: Event.find(params[:id]))
  end

  private
    def event_params
      params.require(:event).permit(:name, :date, :city, :state)
    end

end
