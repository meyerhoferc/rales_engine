require 'rails_helper'

describe "Invoice Relationship API" do
  it "returns a collection of associated transactions" do
    invoice = Fabricate(:invoice)
    invoice2 = Fabricate(:invoice)
    Fabricate.times(2, :transaction, invoice: invoice)
    Fabricate.times(2, :transaction, invoice: invoice2)
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
    invoice2 = Fabricate(:invoice)
    item_one, item_two = Fabricate.times(2, :item)
    Fabricate(:invoice_item, item: item_one, invoice: invoice)
    Fabricate(:invoice_item, item: item_two, invoice: invoice)
    Fabricate(:invoice_item, item: item_two, invoice: invoice2)
    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to be_success
    invoice_item = JSON.parse(response.body)
    expect(invoice_item.count).to eq(2)
    expect(invoice_item.class).to eq(Array)
    expect(invoice_item.first["invoice_id"]).to eq(invoice.id)
    expect(invoice_item.last["invoice_id"]).to eq(invoice.id)
  end

  it "returns a collection of associated items" do
    invoice = Fabricate(:invoice)
    invoice2 = Fabricate(:invoice)
    item_one, item_two = Fabricate.times(2, :item)
    Fabricate(:invoice_item, item: item_one, invoice: invoice)
    Fabricate(:invoice_item, item: item_two, invoice: invoice)
    Fabricate(:invoice_item, item: item_two, invoice: invoice2)


    get "/api/v1/invoices/#{invoice.id}/items"
    expect(response).to be_success
    item = JSON.parse(response.body)
    expect(item.count).to eq(2)
    expect(item.class).to eq(Array)
    expect(item.first["id"]).to eq(item_one.id)
    expect(item.last["id"]).to eq(item_two.id)
  end

  it "returns an associated customer" do
    invoice = Fabricate(:invoice)
    customer1= Fabricate(:customer)
    customer2= Fabricate(:customer, first_name: "Becky")

    get "/api/v1/invoices/#{invoice.id}/customer"
    expect(response).to be_success
    customer_found = JSON.parse(response.body)
    expect(customer_found.count).to eq(3)
    expect(customer_found.class).to eq(Hash)
    expect(customer_found["last_name"]).to eq(customer1.last_name)
    expect(customer_found["first_name"]).to eq(customer1.first_name)
  end

  it "returns an associated merchant" do
    merchant1 = Fabricate(:merchant)
    merchant2 = Fabricate(:merchant)
    invoice = Fabricate(:invoice, merchant: merchant1)

    get "/api/v1/invoices/#{invoice.id}/merchant"
    expect(response).to be_success

    merchant = JSON.parse(response.body)
    expect(merchant.count).to eq(2)
    expect(merchant.class).to eq(Hash)
    expect(merchant["id"]).to eq(merchant1.id)
    expect(merchant["name"]).to eq(merchant1.name)
  end

end
