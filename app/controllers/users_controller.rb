class UsersController < ApplicationController
  def my_portfolio
    @my_stocks = current_user.stocks
  end
end
