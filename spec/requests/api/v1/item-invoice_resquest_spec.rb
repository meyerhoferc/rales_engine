require 'rails_helper'

describe "Invoice-Items API" do
  it "sends a list of invoice-items" do
     Fabricate.times(4, :invoice_item)

    get "/api/v1/invoice_items"

    expect(response).to be_success
    item_invoices = JSON.parse(response.body)
    expect(item_invoices.count).to eq(4)
  end

  it "can get an invoice-item from an id" do
    id = Fabricate(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    expect(response).to be_success
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["id"]).to eq(id)
  end

  it "can get an invoice from query params" do
    invoice_item_one = Fabricate(:invoice_item)
    invoice_item_two = Fabricate(:invoice_item, quantity: 2)

    get "/api/v1/invoice_items/find?unit_price=#{invoice_item_one.unit_price}"

    expect(response).to be_success
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["unit_price"]).to eq(invoice_item_one.unit_price)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item_two.quantity}"
    expect(response).to be_success
    invoice_item = JSON.parse(response.body)
    expect(invoice_item["quantity"]).to eq(2)
  end
end
