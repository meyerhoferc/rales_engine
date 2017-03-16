require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  it { should validate_presence_of(:item_id) }
  it { should validate_presence_of(:invoice_id) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:unit_price) }
  it { should belong_to(:item) }
  it { should belong_to(:invoice) }

  it ".random returns one invoice-item" do
    Fabricate.times(3, :invoice_item)
    expect(InvoiceItem.random.class).to eq(InvoiceItem)
  end
end
