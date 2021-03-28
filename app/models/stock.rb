class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: 'Tpk_03727b5f3fd44f02acac86d6221913c5',
      secret_token: 'Tsk_58910e18896d4200b8d151ac7796343d',
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    client.price(ticker_symbol)
  end
end
