require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should belong_to(:customer) }
  it { should belong_to (:merchant) }
  it { should validate_presence_of(:status) }
  it { should have_many(:invoice_items) }
  it { should have_many(:items) }

  it ".pending returns all invoices with pending transactions" do
    complete_invoices = Fabricate.times(3, :invoice)
    complete_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice)
    end

    pending_invoices = Fabricate.times(2, :invoice)
    pending_invoices.each do |invoice|
      Fabricate(:invoice_item, invoice: invoice)
      Fabricate(:transaction, invoice: invoice, result: "failed")
    end

    expect(Invoice.pending.count).to eq(2)
    expect(Invoice.pending).to eq(pending_invoices)
  end
end
