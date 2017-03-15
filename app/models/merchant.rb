class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  validates :name, presence: true

  def self.highest_revenue(quantity)
    # for a merchant's invoices
    # select all of the invoices where the transaction is successful
    # find the total for that invoice from the invoice-items table
    # then order by this total
    # and take the limit of the quantity
    order(total_revenue: :desc)
    # "SELECT * FROM merchants INNER JOIN invoices ON merchants.invoice_id = invoices.id INNER JOIN transactions ON invoices.transaction_id = transactions.id"
  end

  def self.total_revenue
    byebug
  end

  def favorite_customer
    customers.select('customers.*, count(invoices.merchant_id) AS frequency')
             .joins(invoices: :transactions)
             .merge(Transaction.success)
             .group("customers.id")
             .order('frequency desc').first
  end

  def customers_with_pending_transactions
    customers.joins(invoices: :transactions)
             .merge(Invoice.pending)
             .group("customers.id").to_sql
  end
end
