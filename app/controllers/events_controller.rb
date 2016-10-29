class EventsController < ApplicationController
  def index
    if params[:upcoming]
      @events = Event.upcoming
    else
      @events = Event.all
    end
  end

  def show
    @event = Event.find(params[:id])
  end
end
