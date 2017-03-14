require 'rails_helper'

describe "Invoice APi" do
  it "sends a list of invoices" do
    invoices = Fabricate.times(4, :invoice)

    get "/api/v1/invoices"

    expect(response).to be_success
    invoices = JSON.parse(response.body)
    expect(invoices.count).to eq(4)
  end

  it "can get an invoice from id" do
    id = Fabricate(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)
    expect(response).to be_success
    expect(invoice["id"]).to eq(id)
  end

  it "can get an invoice from query params" do
    invoice_one = Fabricate(:invoice)
    invoice_two = Fabricate(:invoice)

    get "/api/v1/invoices/find?id=#{invoice_one.id}"

    invoice = JSON.parse(response.body)
    expect(response).to be_success
    expect(invoice["id"]).to eq(invoice_one.id)

    get "/api/v1/invoices/find?id=#{invoice_two.id}"

    invoice = JSON.parse(response.body)
    expect(response).to be_success
    expect(invoice["id"]).to eq(invoice_two.id)
  end
end
