class FriendsController < ApplicationController

  #This controller should be deleted
  def search
    if params[:email].present?
      @friend = User.find_by_email(params[:email])
      if @friend
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "#{params[:email]} friend not found - try again"
          format.js { render partial: 'users/friend_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend's email to search for"
        format.js { render partial: 'users/friend_result' }
      end
    end
  end

end