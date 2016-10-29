class TicketType < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :event_id, :price, :name, :max_quantity
  validates_uniqueness_of :name, uniqueness:{scope:[:event_id]}
end
