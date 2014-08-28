class GardensController < ApplicationController

  def create
    garden = current_user.gardens.create!
    flash.notice = "Your garden has been created!"
    redirect_to edit_garden_path(garden)
  end

  def edit
    @garden = Garden.find(params[:id]) # <--- This lets people load gardens that aren't theirs!! When we implement edit, we must fix this vulnerability!
  end

  def update
    @garden = Garden.find(params[:id])
    flash.notice = "Your garden has been updated."
    redirect_to edit_garden_path(@garden)
  end
end
