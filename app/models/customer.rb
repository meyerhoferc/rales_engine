class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices
  validates :first_name, :last_name, presence: true

  def transactions
    Transaction.where(invoice: invoices)
  end

  def self.random
    all.sample
  end

  def favorite_merchant
    merchants
      .select('merchants.*, count(invoices.customer_id) AS frequency')
      .joins(invoices: :transactions)
      .merge(Transaction.success)
      .group("merchants.id")
      .order('frequency desc').first
  end
end
