require 'rails_helper'

describe "Item API" do
  it "sends a list of items" do
    items = Fabricate.times(4, :item)

    get "/api/v1/items"

    expect(response).to be_success
    items = JSON.parse(response.body)
    expect(items.count).to eq(4)
  end

  it "can get an item from id" do
    id = Fabricate(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)
    expect(response).to be_success
    expect(item["id"]).to eq(id)
  end

end
