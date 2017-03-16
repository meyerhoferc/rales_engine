require 'rails_helper'
describe "Items API" do
  it "returns a collection of invoice_items for an item" do
    invoice = Fabricate(:invoice)
    invoice2 = Fabricate(:invoice)
    item_one, item_two = Fabricate.times(2, :item)
    Fabricate(:invoice_item, item: item_one, invoice: invoice)
    Fabricate(:invoice_item, item: item_two, invoice: invoice)
    Fabricate(:invoice_item, item: item_two, invoice: invoice2)
    get "/api/v1/items/#{item_one.id}/invoice_items"

    expect(response).to be_success
    invoice_items = JSON.parse(response.body)
    expect(invoice_items.count).to eq(1)
    expect(invoice_items.class).to eq(Array)
    expect(invoice_items.first["item_id"]).to eq(item_one.id)
    expect(invoice_items.last["item_id"]).to eq(item_one.id)
  end

  it "returns a collection of merchants for an item" do
    merchant = Fabricate(:merchant)
    merchant2 = Fabricate(:merchant)
    item_one = Fabricate(:item, merchant: merchant)
    item_two = Fabricate(:item, merchant: merchant2)

    get "/api/v1/items/#{item_one.id}/merchant"

    expect(response).to be_success
    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(2)
    expect(merchants.class).to eq(Hash)
    expect(merchants["id"]).to eq(merchant.id)
  end
end
