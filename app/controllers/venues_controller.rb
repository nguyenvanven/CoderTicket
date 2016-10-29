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
      render 'new', :notice => "Cannot create new venue"
    end
  end

  private
  def venue_parameters
    params[:venue].permit(:name, :full_address,:region_id)
  end
end
