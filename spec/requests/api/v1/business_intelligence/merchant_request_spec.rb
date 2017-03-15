require 'rails_helper'

describe "Merchant API" do
  it "returns top merchants ranked by total_revenue" do
    merchant_one, merchant_two, merchant_three = Fabricate.times(3, :merchant)
    customer = Fabricate(:customer)
    Fabricate.times(5, :invoice, customer: customer, merchant: merchant_one)
    Fabricate.times(4, :invoice, customer: customer, merchant: merchant_two)
    Fabricate.times(2, :invoice, customer: customer, merchant: merchant_one)

    get "/api/v1/merchants/most_revenue?quantity=2"
    expect(response).to be_success
    merchants = JSON.parse(response.body)
    expect(merchants.first["id"]).to eq(merchant_one.id)
    expect(merchants.last["id"]).to eq(merchant_two.id)
    expect(merchants.count).to eq(2)
  end

  it "returns the customer with the most successful transactions" do
    customer_one, customer_two, customer_three = Fabricate.times(3, :customer)
    merchant = Fabricate(:merchant)
    Fabricate.times(5, :invoice, customer: customer_one, merchant: merchant)
    Fabricate.times(4, :invoice, customer: customer_two, merchant: merchant)
    Fabricate.times(2, :invoice, customer: customer_three, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"
    expect(response).to be_succes
    customer = JSON.parse(response.body)
    expect(customer["id"]).to eq(customer_one).id
  end
end
