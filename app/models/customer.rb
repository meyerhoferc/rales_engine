class Customer < ApplicationRecord
  has_many :invoices
  validates :first_name, :last_name, presence: true

  def transactions
    Transaction.where(invoice: invoices)
  end
end
