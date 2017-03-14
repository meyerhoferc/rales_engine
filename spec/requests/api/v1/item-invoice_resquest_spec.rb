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

  it "can find multiple invoice-items" do
    invoice_items = Fabricate.times(3, :invoice_item, quantity: 3)
    invoice_item_quantity_1 = Fabricate(:invoice_item, quantity: 1)

    get "/api/v1/invoice_items/find_all?quantity=3"
    response_invoice_items = JSON.parse(response.body)
    expect(response).to be_success
    expect(response_invoice_items.class).to eq(Array)
    expect(response_invoice_items.count).to eq(3)
  end

  it "can find a random invoice" do
    invoice_items = Fabricate.times(3, :invoice_item, quantity: 3)
    get "/api/v1/invoice_items/random.json"

    random_invoice_item =  JSON.parse(response.body)
    expect(response).to be_success
    invoice_items.one? { |invoice_item| invoice_item.id == random_invoice_item["id"]}
  end
end
