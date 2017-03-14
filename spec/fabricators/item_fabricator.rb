Fabricator(:item) do
  name        "MyString"
  description "MyText"
  unit_price  15
  merchant    { Fabricate(:merchant) }
end
