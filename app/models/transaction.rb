class Transaction < ApplicationRecord
  belongs_to :invoice
  validates :credit_card_number, :result, :invoice_id, presence: true
  def self.success
    where(result: 'success')
  end
end
