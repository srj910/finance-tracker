class UsersController < ApplicationController
  def my_portfolio
    @my_stocks = current_user.stocks
    @user = current_user
  end

  def my_friends
    @my_friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      exclude_current_user(@friends)
      if @friends && @friends.size > 0
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "#{params[:friend]} not found - try again"
          format.js { render partial: 'users/friend_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend's name or email to search"
        format.js { render partial: 'users/friend_result' }
      end
    end
  end

  def exclude_current_user(friends)
    friends.reject! {|friend| friend.id == current_user.id }
  end

  def show
    @user = User.find(params[:id])
    @my_stocks = @user.stocks
  end
end
