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
end
