class Api::V1::CustomerTransactionSerializer < Api::V1::ApplicationSerializer
    attributes :identifier, :transaction_date, :customer_id, :request_ip, :out_amount, 
            :out_currency, :in_amount, :in_currency
end
