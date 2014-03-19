class VenuesController < ApplicationController
  def show
    @venue = Venue.includes(:shows, :users).find(params[:id])
  end
  def index
    @venues = Venue.all
  end
end