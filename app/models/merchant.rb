class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  validates :name, presence: true

  def self.highest_revenue(quantity)
    joins(invoices: :transactions)
    .merge(Transaction.success)
    .joins(invoices: :invoice_items)
    .group(:id)
    .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .order('total_revenue desc')
    .limit(quantity)
  end

  def favorite_customer
    customers.select('customers.*, count(invoices.merchant_id) AS frequency')
             .joins(invoices: :transactions)
             .merge(Transaction.success)
             .group("customers.id")
             .order('frequency desc').first
  end

  def customers_with_pending_transactions
    customers.select('customers.*')
             .joins(invoices: :transactions)
             .merge(Transaction.where(result: 'failed'))
             .group("customers.id")
  end
end
