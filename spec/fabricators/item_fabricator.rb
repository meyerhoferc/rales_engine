Fabricator(:item) do
  name        "MyString"
  description "MyText"
  unit_price  1.5
  merchant    { Fabricate(:merchant) }
end
