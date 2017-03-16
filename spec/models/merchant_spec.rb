require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:items) }
  it { should have_many(:invoices) }
  it { should have_many(:customers) }
  it { should have_many(:transactions) }

  it ".random returns a merchant" do
    Fabricate.times(3, :merchant)
    expect(Merchant.random.class).to eq(Merchant)
  end

  it ".highest_revenue(quantity) returns a collection of merchants" do
    merchant_one, merchant_two, merchant_three = Fabricate.times(3, :merchant)
    customer = Fabricate(:customer)
    merchant_one_invoices = Fabricate.times(5, :invoice, customer: customer, merchant: merchant_one)
    merchant_two_invoices = Fabricate.times(4, :invoice, customer: customer, merchant: merchant_two)
    merchant_three_invoices = Fabricate.times(2, :invoice, customer: customer, merchant: merchant_one)

    merchant_one_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    merchant_two_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    merchant_three_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    merchants = Merchant.highest_revenue(2)
    expect(merchants.first.id).to eq(merchant_one.id)
    expect(merchants.last.id).to eq(merchant_two.id)
  end

  it ".favorite_customer returns the customer with most transactions for merchant" do
    customer_one, customer_two, customer_three = Fabricate.times(3, :customer)
    merchant = Fabricate(:merchant)
    customer_one_invoices = Fabricate.times(5, :invoice, customer: customer_one, merchant: merchant)
    customer_two_invoices = Fabricate.times(4, :invoice, customer: customer_two, merchant: merchant)
    customer_three_invoices = Fabricate.times(2, :invoice, customer: customer_three, merchant: merchant)

    customer_one_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    customer_two_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    customer_three_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    customer = merchant.favorite_customer
    expect(customer.id).to eq(customer_one.id)
  end

  it ".customers_with_pending_transactions returns just that" do
    customer_one, customer_two, customer_three = Fabricate.times(3, :customer)
    merchant = Fabricate(:merchant)
    customer_one_invoices = Fabricate.times(5, :invoice, customer: customer_one, merchant: merchant)
    customer_two_invoices = Fabricate.times(4, :invoice, customer: customer_two, merchant: merchant)
    customer_three_invoices = Fabricate.times(2, :invoice, customer: customer_three, merchant: merchant)

    customer_one_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice, result: "failed")
    end

    customer_two_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice, result: "success")
    end

    one_failed_transaction_invoice = Fabricate(:invoice, customer: customer_two, merchant: merchant)
    Fabricate(:invoice_item, invoice: one_failed_transaction_invoice)
    Fabricate(:transaction, invoice: one_failed_transaction_invoice, result: "failed")
    Fabricate(:invoice_item, invoice: one_failed_transaction_invoice)
    Fabricate(:transaction, invoice: one_failed_transaction_invoice, result: "success")

    customer_three_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    customers = Merchant.customers_with_pending_transactions(merchant.id)
    expect(customers.first.id).to eq(customer_one.id)
  end

  it ".total_revenue_for_date(date) returns total revenue on a date" do
    date_one = "2012-03-16 11:55:05"
    date_two = "2012-03-07 10:54:55"

    item_one = Fabricate(:item, unit_price: 100)
    item_two = Fabricate(:item, unit_price: 300)
    invoices_date_one = Fabricate.times(2, :invoice, created_at: date_one, updated_at: date_one)
    invoices_date_two = Fabricate.times(2, :invoice, created_at: date_two, updated_at: date_two)

    invoices_date_one.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice, quantity: 3, unit_price: 100, item: item_one)
      Fabricate(:transaction, invoice: invoice)
    end

    invoices_date_two.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice, quantity: 3, unit_price: 300, item: item_two)
      Fabricate(:transaction, invoice: invoice)
    end

    total_revenue = Merchant.total_revenue_for_date(date_one)
    expect(total_revenue).to eq(600.0)
  end

  it ".total_revenue returns total revenue for a merchant" do
    merchant = Fabricate(:merchant)
    merchant_two = Fabricate(:merchant)
    invoice = Fabricate(:invoice, merchant: merchant)
    Fabricate(:invoice, merchant: merchant_two)
    Fabricate(:invoice_item, invoice: invoice)
    Fabricate(:transaction, invoice: invoice)

    total_revenue = merchant.total_revenue
    expect(total_revenue).to eq(1.5)
  end

  it ".revenue_per_date(date) returns total revenue for a merchant" do
    date_one = "2012-03-16 11:55:05"
    date_two = "2012-03-07 10:54:55"

    merchant_one = Fabricate(:merchant)

    item_one = Fabricate(:item, unit_price: 100)
    item_two = Fabricate(:item, unit_price: 300)
    invoices_date_one = Fabricate.times(2, :invoice, merchant: merchant_one, created_at: date_one, updated_at: date_one)
    invoices_date_two = Fabricate.times(2, :invoice, merchant: merchant_one, created_at: date_two, updated_at: date_two)

    invoices_date_one.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice, quantity: 3, unit_price: 100, item: item_one)
      Fabricate(:transaction, invoice: invoice)
    end

    invoices_date_two.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice, quantity: 3, unit_price: 300, item: item_two)
      Fabricate(:transaction, invoice: invoice)
    end

    total_revenue = merchant_one.revenue_per_date(date_one)
    expect(total_revenue).to eq(600)
  end

  it ".items_sold(quantity) returns merchants ranked by items sold" do
    merchant_one = Fabricate(:merchant)
    merchant_two = Fabricate(:merchant)

    item_one = Fabricate(:item)
    item_two = Fabricate(:item)
    invoice_one = Fabricate.times(2, :invoice, merchant: merchant_one)
    invoice_two = Fabricate.times(2, :invoice, merchant: merchant_two)
    invoice_one.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice, quantity: 3, item: item_one)
      Fabricate(:transaction, invoice: invoice)
    end
    invoice_two.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice, quantity: 100, item: item_two)
      Fabricate(:transaction, invoice: invoice)
    end

    merchants = Merchant.items_sold(2)
    expect(merchants.first.id).to eq(merchant_two.id)
    expect(merchants.last.id).to eq(merchant_one.id)
  end
end
