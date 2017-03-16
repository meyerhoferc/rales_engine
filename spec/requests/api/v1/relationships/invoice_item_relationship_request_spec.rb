require 'rails_helper'

describe "Invoice_item Relationships API" do

  it "returns an associated item" do
    item_one = Fabricate(:item)
    item_two = Fabricate(:item)
    invoice = Fabricate(:invoice)
    invoice_two = Fabricate(:invoice)
    invoice_item = Fabricate(:invoice_item, item: item_one, invoice: invoice)
    invoice_item_two = Fabricate(:invoice_item, item: item_two, invoice: invoice_two)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    expect(response).to be_success
    item = JSON.parse(response.body)
    expect(item.class).to eq(Hash)
    expect(item["id"]).to eq(item_one.id)
  end

  it "returns an associated invoice" do
    item_one = Fabricate(:item)
    invoice1 = Fabricate(:invoice)
    invoice2 = Fabricate(:invoice)
    invoice_item = Fabricate(:invoice_item, item: item_one, invoice: invoice1)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    expect(response).to be_success
    invoice = JSON.parse(response.body)
    expect(invoice.class).to eq(Hash)
    expect(invoice["id"]).to eq(invoice1.id)
  end
end
