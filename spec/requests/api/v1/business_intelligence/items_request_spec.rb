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

    it " returns the date with the most sales that item.
     If there are multiple days with equal number of sales,
     return the most recent day" do

     date_one = "2012-03-16T11:55:05.000Z"
     date_two = "2012-03-07 10:54:55"

     merchant_one = Fabricate(:merchant)

     item_one = Fabricate(:item, unit_price: 100)

     invoices_date_one = Fabricate.times(2, :invoice, merchant: merchant_one, created_at: date_one, updated_at: date_one)
     invoices_date_two = Fabricate.times(2, :invoice, merchant: merchant_one, created_at: date_two, updated_at: date_two)

     invoices_date_one.each do |invoice|
       Fabricate(:invoice_item, invoice: invoice, quantity: 3, item: item_one)
       Fabricate(:transaction, invoice: invoice)
     end

     invoices_date_two.each do |invoice|
       Fabricate(:invoice_item, invoice: invoice, quantity: 1, item: item_one)
       Fabricate(:transaction, invoice: invoice)
     end

     get "/api/v1/items/#{item_one.id}/best_day"

     expect(response).to be_success

     date = JSON.parse(response.body)
     expect(date["best_day"]).to eq(date_one)
    #  assert_equal "2012-03-16 11:55:05", date
    #  assert_equal "2012-03-07 10:54:55", best_day_two["best_day"]

 end
end
