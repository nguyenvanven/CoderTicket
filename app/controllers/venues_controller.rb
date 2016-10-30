class VenuesController < ApplicationController
  def new
    @venue = Venue.new
    @regions = Region.all
  end

  def create
    @venue = Venue.new venue_parameters
    if @venue.save
      flash[:success] = "You've created venue successfully"
      redirect_to root_path
    else
      flash[:error] = "Cannot create new venue"
      render 'new'
    end
  end

  private
  def venue_parameters
    params[:venue].permit(:name, :full_address,:region_id)
  end
end
