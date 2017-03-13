require 'rails_helper'

describe "Item API" do
  it "sends a list of items" do
    items = Fabricate.times(4, :item)

    get "/api/v1/items"

    expect(response).to be_success
    items = JSON.parse(response.body)
    expect(items.count).to eq(4)
  end
  
end
