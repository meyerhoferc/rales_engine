class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  validates :item_id, :invoice_id, :quantity, :unit_price, presence: true
end
