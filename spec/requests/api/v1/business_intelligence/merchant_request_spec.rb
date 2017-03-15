require 'rails_helper'

describe "Merchant API" do
  xit "returns top merchants ranked by total_revenue" do
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
    customer_one_invoices = Fabricate.times(5, :invoice, customer: customer_one, merchant: merchant)
    customer_two_invoices = Fabricate.times(4, :invoice, customer: customer_two, merchant: merchant)
    customer_three_invoices = Fabricate.times(2, :invoice, customer: customer_three, merchant: merchant)

    customer_one_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    customer_two_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    customer_three_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"
    expect(response).to be_succes
    customer = JSON.parse(response.body)
    expect(customer["id"]).to eq(customer_one.id)
  end

  it "returns a collection of customers with pending transactions" do
    customer_one, customer_two, customer_three = Fabricate.times(3, :customer)
    merchant = Fabricate(:merchant)
    customer_one_invoices = Fabricate.times(5, :invoice, customer: customer_one, merchant: merchant)
    customer_two_invoices = Fabricate.times(4, :invoice, customer: customer_two, merchant: merchant)
    customer_three_invoices = Fabricate.times(2, :invoice, customer: customer_three, merchant: merchant)

    customer_one_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice, result: "failed")
    end

    customer_two_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice, result: "failed")
    end

    customer_three_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"
    expect(response).to be_success
    customers = JSON.parse(response.body)
    expect(customers.count).to eq(2)
    ids = customers.map { |customer| customer["id"]}

    ids.each do |id|
      expect(id).to_not eq(customer_three.id)
    end
  end
end
