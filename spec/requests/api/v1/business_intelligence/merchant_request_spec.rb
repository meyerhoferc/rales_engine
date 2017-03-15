require 'rails_helper'

describe "Merchant API" do
  it "returns top merchants ranked by total_revenue" do
    merchant_one, merchant_two, merchant_three = Fabricate.times(3, :merchant)
    customer = Fabricate(:customer)
    merchant_one_invoices = Fabricate.times(5, :invoice, customer: customer, merchant: merchant_one)
    merchant_two_invoices = Fabricate.times(4, :invoice, customer: customer, merchant: merchant_two)
    merchant_three_invoices = Fabricate.times(2, :invoice, customer: customer, merchant: merchant_one)

    merchant_one_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    merchant_two_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    merchant_three_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

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
      Fabricate(:transaction, invoice: invoice, result: "success")
    end

    one_failed_transaction_invoice = Fabricate(:invoice, customer: customer_two, merchant: merchant)
    Fabricate(:invoice_item, invoice: one_failed_transaction_invoice)
    Fabricate(:transaction, invoice: one_failed_transaction_invoice, result: "failed")
    Fabricate(:invoice_item, invoice: one_failed_transaction_invoice)
    Fabricate(:transaction, invoice: one_failed_transaction_invoice, result: "success")

    customer_three_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"
    expect(response).to be_success
    customers = JSON.parse(response.body)
    expect(customers.count).to eq(1)
    ids = customers.map { |customer| customer["id"]}

    ids.each do |id|
      expect(id).to_not eq(customer_three.id)
      expect(id).to_not eq(customer_two.id)
    end
  end

  it "returns total revenue for date for all merchants" do
    date_one = "2012-03-16 11:55:05"
    date_two = "2012-03-07 10:54:55"

    item_one = Fabricate(:item, unit_price: 100)
    item_two = Fabricate(:item, unit_price: 300)
    invoices_date_one = Fabricate.times(2, :invoice, created_at: date_one, updated_at: date_one)
    invoices_date_two = Fabricate.times(2, :invoice, created_at: date_two, updated_at: date_two)

    invoices_date_one.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice, quantity: 3, unit_price: 100, item: item_one)
      Fabricate(:transaction, invoice: invoice)
    end

    invoices_date_two.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice, quantity: 3, unit_price: 300, item: item_two)
      Fabricate(:transaction, invoice: invoice)
    end

    get "/api/v1/merchants/revenue?date=#{date_one}"

    expect(response).to be_success
    total_revenue = JSON.parse(response.body)
    expect(total_revenue["total_revenue"]).to eq("6.0")

    get "/api/v1/merchants/revenue?date=#{date_two}"

    expect(response).to be_success
    total_revenue = JSON.parse(response.body)
    expect(total_revenue["total_revenue"]).to eq("18.0")
  end
end
