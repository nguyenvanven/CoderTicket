class TicketsController < ApplicationController
  before_action :set_event, only:[:new, :create]
  def new
    @ticket = Ticket.new
  end

  def create
    if @event.past_event?
      flash[:error] = "Cannot buy ticket for past event"
      render "new"
      return
    end
    @ticket = Ticket.new(event_id:@event.id)
    @ticket.user_id = session[:user_id]
    @event.ticket_types.each do |ticket_type|
      if params["quantity_#{ticket_type.id}"] and params["quantity_#{ticket_type.id}"].to_i > 0
        if ticket_type.over_buying(params["quantity_#{ticket_type.id}"].to_i)
          flash[:error] = "The number of ticket is more than the number available"
          render "new"
          return
        end
        @ticket.ticket_ticket_types.push(TicketTicketType.new(ticket_type_id:ticket_type.id, quantity:params["quantity_#{ticket_type.id}"]))
      end
    end

    if not @ticket.enough_ticket_types?
      flash[:error] = "Please choose at least one type of ticket"
      render "new"
      return
    end

    if @ticket.too_many_ticket?
      flash[:error] = "You cannot buy more than 10 ticket of a tipe at a time"
      render "new"
      return
    end

    if @ticket.save
      flash[:success] = "You've purchase the ticket successfully"
      redirect_to root_path
    else
      flash[:error] = "cannot book your ticket"
      render "new"
    end
  end

  private
  def set_event
    @event = Event.find(params[:event_id])
  end
end
