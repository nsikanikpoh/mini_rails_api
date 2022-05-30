require 'factory_bot'

FactoryBot.define do
    factory(:customer_transaction) do
        identifier { '3Q-HBq5-N7lZ299Pw6Cy-Q' }
        customer_id { 1 }
         in_amount {124.0}
         in_currency {'CAD'}
         request_ip {"::1"}
         transaction_date {"2022-05-19"}
         out_amount {97.69}
         out_currency {"USD"}
    end
  end