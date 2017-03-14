require 'rails_helper'

describe "Invoice-Items API" do
  it "sends a list of invoice-items" do
     Fabricate.times(4, :invoice_item)

    get "/api/v1/invoice_items"

    expect(response).to be_success
    item_invoices = JSON.parse(response.body)
    expect(item_invoices.count).to eq(4)
  end
end
