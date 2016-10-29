require 'rails_helper'

RSpec.describe TicketType, type: :model do
  before(:each) do
    @category = Category.new(name:"Entertainment")
    @category.save
    @venue = Venue.create(name:"Test venue")
    @event = Event.create(extended_html_description:"<h1>description</h1>",name:"Event 1",venue_id: @venue.id, starts_at: DateTime.now + 10.days, category_id: @category.id, publish_at:DateTime.now)
  end
  describe "Validate creation of tiket" do
    it "Has required :event_id, :price, :name, :max_quantity" do
      @ticket_type = TicketType.new
      expect(@ticket_type.save).to be_falsey
      expect(@ticket_type.errors.full_messages.to_sentence).to include("Name can't be blank")
      expect(@ticket_type.errors.full_messages.to_sentence).to include("Event can't be blank")
      expect(@ticket_type.errors.full_messages.to_sentence).to include("Price can't be blank")
      expect(@ticket_type.errors.full_messages.to_sentence).to include("Max quantity can't be blank")

      @ticket_type = TicketType.new(name: "Test Ticket type name",price: 100000, event_id: @event.id, max_quantity: 100)
      expect(@ticket_type.save).to be_truthy
    end

    it "has uniqueness in scope of event and name" do
      @event2 = Event.create(extended_html_description:"<h1>description</h1>",name:"Event 2",venue_id: @venue.id, starts_at: DateTime.now + 11.days, category_id: @category.id, publish_at:DateTime.now)

      @ticket_type1 = TicketType.new(name: "Test Ticket type name",price: 100000, event_id: @event.id, max_quantity: 100)
      expect(@ticket_type1.save).to be_truthy

      @ticket_type2 = TicketType.new(name: "Test Ticket type name",price: 200000, event_id: @event.id, max_quantity: 200)
      expect(@ticket_type2.save).to be_falsey
      expect(@ticket_type2.erros.full_messages.to_sentence).to eq "Event and Name have been already taken"

      @ticket_type2.event_id = @event2.id
      expect(@ticket_type2.save).to be_truthy
    end
  end
end
