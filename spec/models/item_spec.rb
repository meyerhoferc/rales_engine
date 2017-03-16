require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:unit_price) }
  it { should validate_presence_of(:merchant_id) }
  it { should belong_to(:merchant) }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices) }

  it ".random returns an item" do
    Fabricate.times(3, :item)
    expect(Item.random.class).to eq(Item)
  end

  it ".most_revenue(quantity) returns items ordered by quantity" do
    item_one, item_two, item_three = Fabricate.times(3, :item)
    invoice_one, invoice_two, invoice_three = Fabricate.times(3, :invoice)
    Fabricate(:invoice_item, item: item_one, invoice: invoice_one, quantity: 3, unit_price: item_one.unit_price)
    Fabricate(:invoice_item, item: item_two, invoice: invoice_two, quantity: 2, unit_price: item_two.unit_price)
    Fabricate(:invoice_item, item: item_three, invoice: invoice_three, quantity: 1, unit_price: item_three.unit_price)
    Fabricate(:transaction, invoice: invoice_one)
    Fabricate(:transaction, invoice: invoice_two)
    Fabricate(:transaction, invoice: invoice_three)

    items = Item.most_revenue(2)
    expect(items.first.id).to eq(item_one.id)
    expect(items.last.id).to eq(item_two.id)
  end

  it "best_day returns best day per item" do
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

    date = item_one.highest_sale_date
    expect(date.first.created_at).to eq(date_one)
  end
  
  it ".total_sold(quantity) returns ordered items by number of times sold" do
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

    ranked_items = Item.total_sold(2)

    expect(ranked_items.first.id).to eq(item_one.id)
    expect(ranked_items.last.id).to eq(item_two.id)
  end
end
