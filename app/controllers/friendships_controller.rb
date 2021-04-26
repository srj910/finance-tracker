class FriendshipsController < ApplicationController

  def create
    friend = User.find_by_email(params[:email])
    @friendship = Friendship.create(user: current_user, friend: friend)
    flash[:notice] = "#{friend.full_name} was added to your friends"
    redirect_to my_friends_path
  end
 
  def destroy
    friend = User.find(params[:id])
    Friendship.where(user_id: current_user.id, friend_id: friend.id).first.delete
    flash[:notice] = "#{friend.full_name} successfully unfriended"
    redirect_to my_friends_path
  end

end