require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before(:each) do
    @category = Category.new(name:"Entertainment")
    @category.save
    @venue = Venue.create(name:"Test venue")
    @future_event = Event.create(extended_html_description:"<h1>description</h1>",name:"Event in future",venue_id: @venue.id, starts_at: DateTime.now + 10.days, category_id: @category.id)
    @past_event = Event.create(extended_html_description:"<h1>description</h1>",name:"Event in the past",venue_id: @venue.id, starts_at: DateTime.now - 1.days, category_id: @category.id)
  end
  describe "Get #index" do
    it "Response success with http status code 200" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "No parameter will return all event" do
      get :index
      expect(assigns(:events)).to match_array([@future_event,@past_event])
    end

    it "Has parameter upcoming will return upcoming event only" do
      get :index, {:upcoming=>true}
      expect(assigns(:events)).to eq [@future_event]
    end
  end
end
