require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should have_many(:invoices) }
  it { should have_many(:transactions) }

  it ".random returns a single customer" do
    Fabricate.times(3, :customer)
    expect(Customer.random.class).to eq(Customer)
  end

  it ".transactions returns all transactions for a customer" do
    customer = Fabricate(:customer)
    invoice_one, invoice_two, invoice_three = Fabricate.times(3, :invoice, customer: customer)
    Fabricate(:invoice_item, invoice: invoice_one)
    Fabricate(:invoice_item, invoice: invoice_two)
    Fabricate(:invoice_item, invoice: invoice_three)
    expected_transactions = []
    expected_transactions << Fabricate(:transaction, invoice: invoice_one)
    expected_transactions << Fabricate(:transaction, invoice: invoice_two)
    expected_transactions << Fabricate(:transaction, invoice: invoice_three)

    transactions = customer.transactions
    expect(transactions[0]).to eq(expected_transactions[0])
    expect(transactions[1]).to eq(expected_transactions[1])
    expect(transactions[2]).to eq(expected_transactions[2])
  end

  it ".favorite_merchant returns a customer's favorite merchant" do
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

    favorite_merchant = customer.favorite_merchant
    expect(favorite_merchant.id).to eq(merchant_one.id)
  end
end
