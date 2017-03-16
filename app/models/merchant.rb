class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  validates :name, presence: true

  def self.highest_revenue(quantity)
    joins(invoices: [:transactions, :invoice_items])
      .merge(Transaction.success)
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
             .merge(Transaction.failed)
             .group("customers.id")
  end

  def self.total_revenue_for_date(date)
    joins(invoices: [:transactions, :invoice_items])
      .where('invoices.created_at = ?', date)
      .merge(Transaction.success)
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def total_revenue
    invoices.joins(:transactions, :invoice_items)
    .where(transactions: {result: "success"})
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
