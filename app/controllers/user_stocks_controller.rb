class UserStocksController < ApplicationController

  def create
    stock = Stock.fetch_by_ticker(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was added to your portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    UserStock.where(user_id: current_user.id, stock_id: stock.id).first.delete
    flash[:notice] = "#{stock.ticker} successfully removed from portfolio"
    redirect_to my_portfolio_path
  end
end
