require 'rails_helper'

RSpec.describe "venues/new.html.erb", type: :view do
  it "render new form for venue" do
    assign(:regions,[Region.new(:id=>1, :name=>"Ha Noi")])
    assign(:venue, Venue.new)
    render
    expect(rendered).to match /Ha Noi/
  end
end
