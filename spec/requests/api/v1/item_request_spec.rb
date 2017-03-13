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

  it "can get an item by name or description" do
    item_one = Fabricate(:item, name: "Item One")
    item_two = Fabricate(:item, description: "This Description")

    get "/api/v1/items/find?name=#{item_one.name}"

    item = JSON.parse(response.body)
    expect(response).to be_success
    expect(item["name"]).to eq(item_one.name)
    expect(item["name"]).to_not eq(item_two.name)
    expect(item["description"]).to eq(item_one.description)
    expect(item["description"]).to_not eq(item_two.description)

    get "/api/v1/items/find?description=#{item_two.description}"

    item = JSON.parse(response.body)
    expect(response).to be_success
    expect(item["name"]).to eq(item_two.name)
    expect(item["name"]).to_not eq(item_one.name)
    expect(item["description"]).to eq(item_two.description)
    expect(item["description"]).to_not eq(item_one.description)
  end
end
