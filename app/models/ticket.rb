class Ticket < ActiveRecord::Base
  has_many :ticket_ticket_types
  belongs_to :event
  belongs_to :user

  def enough_ticket_types?
    return ticket_ticket_types.any?{|t| t.quantity > 0}
  end

  def too_many_ticket?
    ticket_ticket_types.any?{|t| t.quantity > 10}
  end
end
