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
end
