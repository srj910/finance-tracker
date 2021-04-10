class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  MAX_TRACKABLE_STOCKS = 10
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def can_track_stock?(ticker_symbol)
    stocks.count < MAX_TRACKABLE_STOCKS && 
      !stocks.where(ticker: ticker_symbol).exists?
  end

  def tracking_limit_reached?
    stocks.count >= MAX_TRACKABLE_STOCKS
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end
end
