require 'rails_helper'

describe "Merchant API" do
  it "returns a collection of items for a merchant" do
    merchant = Fabricate(:merchant)
    Fabricate.times(2, :item, merchant: merchant)
    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_success
    items = JSON.parse(response.body)
    expect(items.count).to eq(2)
    expect(items.class).to eq(Array)
    expect(items.first["merchant_id"]).to eq(merchant.id)
    expect(items.last["merchant_id"]).to eq(merchant.id)
  end

  it "returns a collection of invoices for a merchant" do
    merchant = Fabricate(:merchant)
    Fabricate.times(2, :invoice, merchant: merchant)
    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_success
    invoices = JSON.parse(response.body)
    expect(invoices.count).to eq(2)
    expect(invoices.class).to eq(Array)
    expect(invoices.first["merchant_id"]).to eq(merchant.id)
    expect(invoices.last["merchant_id"]).to eq(merchant.id)
  end
end
