Fabricator(:invoice_item) do
  item       { Fabricate(:item) }
  invoice    { Fabricate(:invoice) }
  quantity   1
  unit_price 1.5
end
