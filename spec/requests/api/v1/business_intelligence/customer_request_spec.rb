require 'rails_helper'

describe "Customer Business Intelligence API" do
  it "returns a merchant where customer has had the most successful transactions" do
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

    get  "/api/v1/customers/#{customer.id}/favorite_merchant"

    expect(response).to be_success
    merchant = JSON.parse(response.body)
    expect(merchant["id"]).to eq(merchant_one.id)
    expect(merchant["id"]).to_not eq(merchant_two.id)
  end
end
