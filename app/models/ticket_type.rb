class TicketType < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :event_id, :price, :name, :max_quantity
  validates_uniqueness_of :name, uniqueness:{scope:[:event_id]}
  has_many :ticket_ticket_types

  def over_buying(quantity)
    return quantity > available_tickets
  end

  def available_tickets
    return max_quantity - ticket_ticket_types.inject(0){|sum,e| sum + e.quantity}
  end
end
