class UsersController < ApplicationController

  before_action :set_user, only: [:show, :index]

  def new
    @user = User.new
  end

  def show

  end

  def create
    STDERR.puts user_params.merge(role: Random.rand%2 == 0?'admin':'user').inspect

    #If you are lucky - you are admin! (50% chance)
    @user = User.new user_params.merge(role: Random.rand%2 == 0?'admin':'user')

    if @user.save
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  private

  def set_user
    @user = User.find params[:id] if params[:id]
  end

  def user_params
    params.require(:user).permit(:id,:email,:password,:password_confirmation)
  end
end
