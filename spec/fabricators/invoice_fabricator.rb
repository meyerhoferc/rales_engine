Fabricator(:invoice) do
  customer { Fabricate(:customer) }
  merchant { Fabricate(:merchant) }
  status   "MyString"
end
