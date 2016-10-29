class TicketTypesController < ApplicationController
  def new
    @ticket_type = TicketType.new
    @ticket_type.event_id = params[:event_id]
  end
  def create
    @ticket_type = TicketType.new ticket_type_params
    if @ticket_type.save
      flash[:success] = "Add ticket type successfully"
      redirect_to ticket_types_new_path, {:event_id => @ticket_type.event_id}
    else
      render 'new', notice: "Create ticket type failed"
    end
  end

  private
  def ticket_type_params
    params[:ticket_type].permit(:event_id, :price, :name, :max_quantity)
  end
end
