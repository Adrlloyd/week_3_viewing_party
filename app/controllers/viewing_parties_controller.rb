class ViewingPartiesController < ApplicationController
  before_action :check_user, only: [:new]

  def new
  end

  private

  def check_user
    unless current_user
      flash[:error] = "Login in or register to create a move party"
      redirect_to root_path
    end
  end
end