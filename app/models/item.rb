class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  validates :name, :description, :unit_price, :merchant_id, presence: true

  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.success)
      .group(:id)
      .order('sum(invoice_items.quantity * invoice_items.unit_price) desc')
      .limit(quantity)
  end

  def self.random
    all.sample
  end
end
