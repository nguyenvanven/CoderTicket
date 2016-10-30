class TicketTicketType < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :ticket_type
end
