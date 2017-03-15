class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  validates :status, presence: true

  def self.pending
    joins(:transactions).where(transactions: {result: "failed"})
  end
end
