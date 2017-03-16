class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  validates :first_name, :last_name, presence: true

  def transactions
    Transaction.where(invoice: invoices)
  end

  def self.random
    all.sample
  end
end
