class CustomerTransaction < ApplicationRecord

    validate  :transaction_date_valid
    validates :identifier, presence: true
    validates :customer_id, presence: true
    validates :request_ip, presence: true
    validates :in_currency, presence: true
    validates :out_currency, presence: true

    validates :in_amount, presence: true
    validates :out_amount, presence: true


    private



    def transaction_date_valid
      errors.add(:transaction_date, "can not be in the future") if
      !transaction_date.blank? && transaction_date > Date.today
    end

end
  