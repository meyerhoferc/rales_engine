class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :unit_price, :quantity
end
