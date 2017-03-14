require 'rails_helper'

describe "Merchant API" do
  it "returns a collection of items for a merchant" do
    merchant = Fabricate(:merchant)
    item_one, item_two = Fabricate.times(2, :item, merchant: merchant)
    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_success
    items = JSON.parse(response.body)
    expect(items.count).to eq(2)
    expect(items.class).to eq(Array)
    expect(items.first["merchant_id"]).to eq(merchant.id)
    expect(items.last["merchant_id"]).to eq(merchant.id)
  end
end
