class RidesController < ApplicationController
  def create
    @ride = Ride.new(ride_params)
    if @ride.save
      flash[:notice] = @ride.take_ride
      redirect_to user_path(current_user)
    else
      flash[:notice] = "Oops! Looks like that ride is unavailable."
      redirect_to user_path(current_user)
    end

  end

  private

  def ride_params
    params.permit(:attraction_id, :user_id)
  end
end