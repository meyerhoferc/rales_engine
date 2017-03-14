class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :unit_price, :quantity, :item_id, :invoice_id

  attribute :unit_price do
    (object.unit_price / 100).round(2).to_s
  end
end
