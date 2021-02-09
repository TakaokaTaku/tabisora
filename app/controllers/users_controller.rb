class UsersController < ApplicationController
  before_action :sign_in_required

  def show
    @user = User.find(params[:id])
  end

  def index
  end
end
