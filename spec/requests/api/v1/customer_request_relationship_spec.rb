require 'rails_helper'

describe "Customer API" do
  it "returns a collection of invoices for a customer" do
    customer = Fabricate(:customer)
    invoices = Fabricate.times(3, :invoice, customer: customer)
    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to be_success
    invoices = JSON.parse(response.body)
    expect(invoices.count).to eq(3)
    expect(invoices.first["customer_id"]).to eq(customer.id)
    expect(invoices.last["customer_id"]).to eq(customer.id)
  end
end
