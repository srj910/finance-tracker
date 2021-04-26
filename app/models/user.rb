class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
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

  def to_s
    "name: #{full_name}, email: #{email}"
  end

  def is_friends_with?(friend_email)
    friends.where(email: friend_email).exists?
  end

  def is_not_friends_with?(friend_email)
    !is_friends_with?(friend_email)
  end

  def can_add_friend?(friend_email)
    User.find_by_email(friend_email) != self
  end

  def self.search(search_string)
    search_string.strip!
    result = []
    ['email','first_name','last_name'].each do |search_field|
      result += search_in_field(search_field, search_string)
    end
    result.uniq
  end

  def self.search_in_field(field, value)
    where("#{field} like ?", "%#{value}%")
  end
end
