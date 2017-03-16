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
end
