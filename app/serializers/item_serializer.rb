class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :unit_price, :merchant_id

  def unit_price
    object.unit_price.to_i.to_s.chars.insert(-3, ".").join
  end
end
