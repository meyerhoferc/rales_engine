require 'rails_helper'

describe "Customer API" do
  it "returns a collection of invoices for a customer" do
    customer = Fabricate(:customer)
    invoices = Fabricate.times(3, :invoice, customer: customer)
    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to be_success
    resulting_invoices = JSON.parse(response.body)
    expect(resulting_invoices.count).to eq(3)
    expect(resulting_invoices.first["customer_id"]).to eq(customer.id)
    expect(resulting_invoices.last["customer_id"]).to eq(customer.id)
  end

  it "returns a collection of transactions for a customer" do
    customer = Fabricate(:customer)
    invoice = Fabricate(:invoice, customer: customer)
    unrelated_invoice = Fabricate(:invoice)
    transactions = Fabricate.times(3, :transaction, invoice: invoice)
    unrelated_transactions = Fabricate.times(3, :transaction, invoice: unrelated_invoice)
    get "/api/v1/customers/#{customer.id}/transactions"

    expect(response).to be_success
    resulting_transactions = JSON.parse(response.body)
    expect(resulting_transactions.count).to eq(3)
    resulting_transactions.all? do |transaction|
      expect(transaction["id"]).to eq(invoice.id)
    end
  end
end
