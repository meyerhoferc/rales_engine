require 'rails_helper'

describe "Items API" do
  it " returns the top item ranked by total number sold" do

    item_one, item_two, item_three = Fabricate.times(3, :item)
    merchant_one, merchant_two, merchant_three = Fabricate.times(3, :merchant)
    merchant_one_invoices = Fabricate.times(5, :invoice, merchant: merchant_one)
    merchant_two_invoices = Fabricate.times(4, :invoice, merchant: merchant_two)
    merchant_three_invoices = Fabricate.times(2, :invoice, merchant: merchant_one)

    merchant_one_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice, item: item_one, quantity: 3)
      Fabricate(:transaction, invoice: invoice)
    end

    merchant_two_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice, item: item_two, quantity: 2)
      Fabricate(:transaction, invoice: invoice)
    end

    merchant_three_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice, item: item_three, quantity: 1)
      Fabricate(:transaction, invoice: invoice)
    end


    get "/api/v1/items/most_items?quantity=3"

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.first["id"]).to eq(item_one.id)
    expect(items.last["id"]).to eq(item_three.id)
    expect(items.first["id"]).to_not eq(item_two.id)

  end
end
