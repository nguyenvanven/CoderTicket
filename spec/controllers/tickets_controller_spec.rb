require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  before(:each) do
    @category = Category.new(name:"Entertainment")
    @category.save
    @venue = Venue.create(name:"Test venue")
    @event = Event.create(extended_html_description:"<h1>description</h1>",name:"Event in future",venue_id: @venue.id, starts_at: DateTime.now + 10.days, category_id: @category.id)
    @ticket_type = TicketType.create(event_id:@event.id, name:"Test type name", price:100000, max_quantity:100)
  end
  describe "Get #new" do
    it "Return success with http status code 200" do
      get :new, {:event_id=> @event.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "Return new ticket" do
      get :new, {:event_id=> @event.id}
      expect(assigns(:ticket)).to be_truthy
    end
  end

  describe "Post create" do
    it "Have error if no ticket purchased" do
      post :create, {:event_id=> @event.id, "quantity_#{@ticket_type.id}" => 0}
      expect(flash[:error]).to eq "Please choose at least one type of ticket"
    end

    it "Have success message if a ticket is choosen" do
      post :create, {:event_id=> @event.id, "quantity_#{@ticket_type.id}" => 1}
      expect(flash[:success]).to eq "You've purchase the ticket successfully"
    end

    it "Have error message if buying more than 10 ticket of a type" do
      post :create, {:event_id=> @event.id, "quantity_#{@ticket_type.id}" => 11}
      expect(flash[:error]).to eq "You cannot buy more than 10 ticket of a tipe at a time"
    end

    it "Has error meessage if buying over the number" do
      post :create, {:event_id=> @event.id, "quantity_#{@ticket_type.id}" => 101}
      expect(flash[:error]).to eq "The number of ticket is more than the number available"
    end
  end
end
