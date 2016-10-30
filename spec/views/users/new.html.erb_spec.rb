require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new())
  end

  it "renders new user form" do
    render
    assert_select "form[action=?][method=?]", users_path, "post" do
    end
  end

  it "show user error message" do
    @user = User.new
    @user.errors.messages[:email]=["cannot be blank"]
    assign(:user, @user)
    render
    expect(rendered).to match /Email cannot be blank/

  end
end
