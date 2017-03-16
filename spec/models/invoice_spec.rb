require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should belong_to(:customer) }
  it { should belong_to (:merchant) }
  it { should validate_presence_of(:status) }
  it { should have_many(:invoice_items) }
  it { should have_many(:items) }

  it ".random returns a single invoice" do
    Fabricate.times(3, :invoice)
    expect(Invoice.random.class).to eq(Invoice)
  end
end
