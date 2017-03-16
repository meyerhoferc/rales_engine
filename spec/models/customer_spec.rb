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
end
