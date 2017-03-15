require 'rails_helper'
describe "Invoice API" do
  it "returns a collection of associated transactions" do
    invoice = Fabricate(:invoice)
    Fabricate.times(2, :transaction, invoice: invoice)
    get "/api/v1/invoices/#{invoice.id}/transactions"

    expect(response).to be_success
    transactions = JSON.parse(response.body)
    expect(transactions.count).to eq(2)
    expect(transactions.class).to eq(Array)
    expect(transactions.first["invoice_id"]).to eq(invoice.id)
    expect(transactions.last["invoice_id"]).to eq(invoice.id)
  end

  it "returns a collection of associated invoice items" do
    invoice = Fabricate(:invoice)
    item_one, item_two = Fabricate.times(2, :item)
    Fabricate(:invoice_item, item: item_one, invoice: invoice)
    Fabricate(:invoice_item, item: item_two, invoice: invoice)
    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to be_success
    invoice_item = JSON.parse(response.body)
    expect(invoice_item.count).to eq(2)
    expect(invoice_item.class).to eq(Array)
    expect(invoice_item.first["invoice_id"]).to eq(invoice.id)
    expect(invoice_item.last["invoice_id"]).to eq(invoice.id)
  end
end
