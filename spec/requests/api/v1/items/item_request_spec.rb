require 'rails_helper'

describe "Items API" do
  it "returns the items with the most revenue" do
    item_one, item_two, item_three = Fabricate.times(3, :item)
    invoice_one, invoice_two, invoice_three = Fabricate.times(3, :invoice)
    Fabricate(:invoice_item, item: item_one, invoice: invoice_one, quantity: 3, unit_price: item_one.unit_price)
    Fabricate(:invoice_item, item: item_two, invoice: invoice_two, quantity: 2, unit_price: item_two.unit_price)
    Fabricate(:invoice_item, item: item_three, invoice: invoice_three, quantity: 1, unit_price: item_three.unit_price)

    get "/api/v1/items/most_revenue?quantity=2"
    expect(response).to be_success
    items = JSON.parse(response.body)
    expect(items.count).to eq(2)
    expect(items.class).to eq(Array)
    ids = items.map { |item| item["id"] }
    expect(ids.first).to eq(item_one.id)
    expect(ids.last).to eq(item_two.id)
  end
end
