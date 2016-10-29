require 'rails_helper'
require 'date'

RSpec.describe Event, type: :model do
  before(:each) do
    @category = Category.new(name:"Entertainment")
    @category.save
    @venue = Venue.create(name:"Test venue")
  end
 describe "Test validation Required" do
 	it "Has extended_html_description, venue, cate" do
 		@event = Event.new
 		expect(@event.save).to be_falsey
 		expect(@event.errors.full_messages.to_sentence).to include("Extended html description can't be blank")
    expect(@event.errors.full_messages.to_sentence).to include("Venue can't be blank")
    expect(@event.errors.full_messages.to_sentence).to include("Category can't be blank")
    expect(@event.errors.full_messages.to_sentence).to include("Starts at can't be blank")
    @event.extended_html_description = "<h1>Test description</h1>";
    @event.venue_id = @venue.id
    @event.category_id = @category.id
    @event.starts_at = Date.parse('31-12-2015')
    expect(@event.save).to be_truthy
 	end

 	it "Has unique name" do
    @event1 = Event.new(extended_html_description:"<h1>description",name:"event 1",venue_id: @venue.id, starts_at: Date.parse('31-12-2015'), category_id: @category.id)
    @event1.save
    @event = Event.new(extended_html_description:"<h1>description",name:"event 1",venue_id: @venue.id, starts_at: Date.parse('30-12-2015'), category_id: @category.id)
    expect(@event.save).to be_falsey
 		expect(@event.errors.full_messages.to_sentence).to include("Name has already been taken")

    @event.name = "Event 2"
    expect(@event.save).to be_truthy
 	end

  # it "Has unique pair of (venue, starts_at)" do
  #   @event1 = Event.new(extended_html_description:"<h1>description",name:"event 1",venue_id: @venue.id, starts_at: DateTime.new(2015,05,05,00,00), category_id: @category.id,)
  #   @event1.save
  #   @event = Event.new(extended_html_description:"<h1>description",name:"event 2",venue_id: @venue.id, starts_at: DateTime.new(2015,05,05,00,00), category_id: @category.id,)
  #   expect(@event.save).to be_falsey
 # 		expect(@event.errors.full_messages.to_sentence).to include("Name has already been taken")
  #
  #   @event.starts_at = Date.parse('30-12-2015')
  #   expect(@event.save).to be_truthy
  # end
 end

 describe "Test upcoming events" do
   it "Get event in future only" do
     @futureEvent = Event.create(extended_html_description:"<h1>description</h1>",name:"Event in future",venue_id: @venue.id, starts_at: DateTime.now + 10.days, category_id: @category.id)
     @pastEvent = Event.create(extended_html_description:"<h1>description</h1>",name:"Event in the past",venue_id: @venue.id, starts_at: DateTime.now - 1.days, category_id: @category.id)
     expect(Event.upcoming.any?{|e| e.id == @futureEvent.id }).to be_truthy
     expect(Event.upcoming.any?{|e| e.id == @pastEvent.id}).to be_falsey
   end
 end
end
