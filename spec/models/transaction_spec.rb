require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should validate_presence_of(:credit_card_number) }
  it { should validate_presence_of(:result) }
  it { should validate_presence_of(:invoice_id) }
  it { should belong_to(:invoice) }

  it ".succes returns transacations where result is successful" do
    successful_transactions = Fabricate.times(3, :transaction, result: "success")
    unsuccessful_transactions = Fabricate.times(2, :transaction, result: "pending")

    expect(Transaction.success.count).to eq(3)
    expect(Transaction.success).to eq(successful_transactions)
  end
end
