Fabricator(:transaction) do
  invoice { Fabricate(:invoice) }
  credit_card_number 1
  result             "MyString"
end
