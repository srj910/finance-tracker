class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "#{params[:stock]} not found - try again"
          format.js { render partial: 'users/result' }
          # format.js { redirect_to my_portfolio_path }
          # redirect_with_message("#{params[:stock]} not found - try again")
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a stock ticker symbol to search for"
        format.js { render partial: 'users/result' }
        # format.js { redirect_to my_portfolio_path }
        # redirect_with_message("Please enter a stock ticker symbol to search for")
      end
    end
  end

  private

  def redirect_with_message(message)
    flash.now[:alert] = message
    # redirect_to my_portfolio_path
    render partial: 'users/result'
  end
end