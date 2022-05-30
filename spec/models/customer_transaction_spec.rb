require 'rails_helper'

RSpec.describe CustomerTransaction, type: :model do
  let(:customer_transaction) { build(:customer_transaction) }

  it "is valid with identifer" do
    expect(customer_transaction).to be_valid
  end

  it "is not valid without identifer" do
    customer_transaction.identifier = nil
    expect(customer_transaction).not_to be_valid
  end

  it 'is not valid without a valid customer_id' do
    customer_transaction.customer_id = nil
    expect(customer_transaction).not_to be_valid
  end

  it "is not valid without in_amount" do
    customer_transaction.in_amount = nil
    expect(customer_transaction).not_to be_valid
  end

  it "is not valid without in_currency" do
    customer_transaction.in_currency = nil
    expect(customer_transaction).not_to be_valid
  end

  it "is not valid without out_amount" do
    customer_transaction.out_amount = nil
    expect(customer_transaction).not_to be_valid
  end

  it "is not valid without out_currency" do
    customer_transaction.out_currency = nil
    expect(customer_transaction).not_to be_valid
  end

  it "is not valid without a future transaction_date" do
    customer_transaction.transaction_date = Date.tomorrow
    expect(customer_transaction).not_to be_valid
  end

  it "is not valid without request_ip" do
    customer_transaction.request_ip = nil
    expect(customer_transaction).not_to be_valid
  end

end
