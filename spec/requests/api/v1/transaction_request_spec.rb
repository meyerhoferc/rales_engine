require 'rails_helper'

describe "Transaction API" do
  it "sends a list of transactions" do
    transactions = Fabricate.times(4, :transaction)

    get '/api/v1/transactions'

    expect(response).to be_success
    transactions = JSON.parse(response.body)
    expect(transactions.count).to eq(4)
  end

  it "can get an individual transaction from id" do
    id = Fabricate(:transaction).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)
    expect(response).to be_success
    expect(transaction["id"]).to eq(id)
  end

  it "can get a transaction from credit card number" do
    transaction_one = Fabricate(:transaction)
    transaction_two = Fabricate(:transaction, credit_card_number: 0000)

    get "/api/v1/transactions/find?credit_card_number=#{transaction_one.credit_card_number}"

    transaction = JSON.parse(response.body)
    expect(response).to be_success
    expect(transaction["credit_card_number"]).to eq(transaction_one.credit_card_number)
    expect(transaction["credit_card_number"]).to_not eq(transaction_two.credit_card_number)
  end

  it "can get all transactions for result" do
    transaction_one = Fabricate(:transaction)
    transaction_two = Fabricate(:transaction, result: "failed")
    transaction_three = Fabricate(:transaction, result: "failed")

    get "/api/v1/transactions/find_all?result=failed"

    transaction = JSON.parse(response.body)
    expect(response).to be_success
    expect(transaction.count).to eq(2)
  end

  it "find a random transaction" do
    transactions = Fabricate.times(4, :transaction)

    get "/api/v1/transactions/random.json"

    random_transaction = JSON.parse(response.body)
    expect(response).to be_success
    transactions.one? { |transaction| transaction.id == random_transaction["id"]}
  end

  it "find a transaction with invoice id" do
    transaction_one = Fabricate(:transaction)
    get "/api/v1/transactions/find?invoice_id=#{transaction_one.invoice_id}"

    transaction = JSON.parse(response.body)
    expect(response).to be_success
    expect(transaction["invoice_id"]).to eq(transaction_one.invoice_id)

  end
end
