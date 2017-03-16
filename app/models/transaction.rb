class Transaction < ApplicationRecord
  belongs_to :invoice
  validates :credit_card_number, :result, :invoice_id, presence: true
  scope :success, -> { where(result: 'success') }

  def self.random
    all.sample
  end
end
