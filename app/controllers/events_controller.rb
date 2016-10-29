class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_edit_right, only: [:edit, :update]
  def index
    if params[:upcoming]
      @events = Event.upcoming(params[:search])
    else
      @events = Event.search_all(params[:search])
    end
  end

  def mine
    @events = Event.my_events(current_user.id)
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

  def edit
    @event = Event.new
    @venues = Venue.all
    @event = Event.find(params[:event_id])
    @categories = Category.all
  end

  def update
    if @event.update(event_params)
      flash[:success]="Event has been updated successfully"
      render 'show', {:event_id=>@event.id}
    else
      flash[:error] = "Cannot update the event"
      render 'edit'
    end
  end

  private
  def set_event
      @event = Event.find(params[:id])
  end
  def check_edit_right
    @event = Event.find(params[:id])
    if @event.created_by != current_user.id
      flash[:error] = "You don't have permission to edit this event"
      redirect_to :back
    end
  end
  def event_params
    params[:event].permit(:starts_at,:ends_at,:venue_id,:hero_image_url,:extended_html_description,:category_id,:name)
  end
end
