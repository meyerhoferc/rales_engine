require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:items) }
  it { should have_many(:invoices) }
end
