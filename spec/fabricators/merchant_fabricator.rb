Fabricate.sequence(:name)

Fabricator(:merchant) do
  name { sequence(:name, 0) }
end
