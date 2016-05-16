class AttractionsController < ApplicationController
  before_action :set_attraction, only: [:show, :edit, :update, :destroy]

  def index
    @attractions = Attraction.all
  end

  def show
  end

  def new
    if authorized?
      @attraction = Attraction.new
    else
      flash[:alert] = "You must be signed in and an admin to create a new attraction."
      redirect_to attractions_path
    end
  end

  def create
    @attraction = Attraction.new(attraction_params)
    if @attraction.save
      flash[:notice] = "Attraction was successfully created."
      redirect_to attraction_path(@attraction)
    else
      flash[:notice] = "Attraction could not be created."
      render :new
    end
  end

  def edit
    unless authorized?
      flash[:alert] = "You must be signed in and an admin to edit an attraction."
      redirect_to attractions_path
    end
  end

  def update
    @attraction.update(attraction_params)
    flash[:notice] = "Attraction was successfully updated."
    redirect_to attraction_path(@attraction)
  end

  def destroy
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height)
  end

  def set_attraction
    @attraction = Attraction.find(params[:id])
  end

  def authorized?
    logged_in? && current_user.admin?
  end

end