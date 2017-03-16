class DateSerializer < ActiveModel::Serializer
  attributes :best_day

  attribute :best_day do
    (object.first.created_at)
  end
end
