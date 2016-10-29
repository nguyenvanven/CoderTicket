class EventsController < ApplicationController
  def index
    if params[:upcoming]
      @events = Event.upcoming(params[:search])
    else
      @events = Event.search_all(params[:search])
    end
  end

  def unpublished_events
    @events = Event.unpublished_events(current_user.id)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @venues = Venue.all
    @categories = Category.all
  end

  def create
    @event = Event.new event_params
    @event.created_by = current_user.id
    if @event.save
      flash[:success] = "You've created event successfully"
      redirect_to root_path
    else
      flash[:error] = "Cannot create event"
      render 'new'
    end
  end

  def publish
    if params[:event_id] and Event.publish(params[:event_id])
      flash[:success] = "The event has been publish successfully"
      redirect_to root_path
    else
      flash[:errors] = "Cannot publish event"
      redirect_to :back
    end
  end

  private
  def event_params
    params[:event].permit(:starts_at,:ends_at,:venue_id,:hero_image_url,:extended_html_description,:category_id,:name)
  end
end
