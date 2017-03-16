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
    customers
      .select('customers.*, count(invoices.merchant_id) AS frequency')
      .joins(invoices: :transactions)
      .merge(Transaction.success)
      .group("customers.id")
      .order('frequency desc').first
  end

  def self.customers_with_pending_transactions(id)
    find_by_sql("SELECT customers.* FROM customers INNER JOIN invoices ON customers.id = invoices.customer_id INNER JOIN transactions ON transactions.invoice_id = invoices.id INNER JOIN merchants ON merchants.id = invoices.merchant_id
                WHERE merchant_id = #{id} AND transactions.result = 'failed'
                GROUP BY customers.id
                EXCEPT
                SELECT customers.*
                FROM customers
                  INNER JOIN invoices ON customers.id = invoices.customer_id
                  INNER JOIN transactions ON transactions.invoice_id = invoices.id
                  INNER JOIN merchants ON merchants.id = invoices.merchant_id
                WHERE merchant_id = #{id} AND transactions.result = 'success'
                GROUP BY customers.id;")
  end

  def self.total_revenue_for_date(date)
    joins(invoices: [:transactions, :invoice_items])
      .where('invoices.created_at = ?', date)
      .merge(Transaction.success)
      .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
