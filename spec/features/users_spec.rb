require 'rails_helper'

RSpec.feature "Users", type: :feature do
  describe "routing session", :type=> :routing do
    it "Routing get login to session new" do
      expect(:get => "/login").to route_to(
        :controller => "sessions",
        :action => "new"
      )
    end

    it "Routing post login to session create" do
      expect(:post => "/login").to route_to(
        :controller => "sessions",
        :action => "create"
      )
    end

    it "Routing get logout to session destroy" do
      expect(:get => "/logout").to route_to(
        :controller => "sessions",
        :action => "destroy"
      )
    end
  end
end
