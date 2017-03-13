class Item < ApplicationRecord
  belongs_to :merchant
  validates :name, :description, :unit_price, :merchant_id, presence: true
end
