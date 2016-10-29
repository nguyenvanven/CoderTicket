class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def create
    @ticket_type = TicketType.new ticket_type_params
    if @ticket_type.save
      flash[:success] = "Create ticket successfully"
      redirect_to event_path(:id=>@ticket_type.event_id)
    else
      render 'new', notice:"Cannot create ticket type"
    end
  end

  private

  def ticket_type_params
    params[:ticket_type].permit(:event_id, :price, :name, :max_quantity)
  end
end
