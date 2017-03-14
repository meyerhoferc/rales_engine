require 'rails_helper'

describe "Transaction API" do
  it "returns the associated invoice" do
    invoice = Fabricate(:invoice)
    transaction = Fabricate(:transaction, invoice: invoice)
    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(response).to be_success
    associated_invoice = JSON.parse(response.body)
    expect(associated_invoice["id"]).to eq(invoice.id)
  end
end
