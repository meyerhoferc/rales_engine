class Customer < ApplicationRecord
  has_many :invoices
  validates :first_name, :last_name, presence: true

  def transactions
    invoices.joins(:transactions)
  end
end
