require 'rails_helper'

describe "Item Record API" do
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

  it "can find an item by unit price" do
    item_one = Fabricate(:item, unit_price: 49121)

    get "/api/v1/items/find?unit_price=#{"491.21"}"

    item = JSON.parse(response.body)
    expect(response).to be_success
    expect(item["name"]).to eq(item_one.name)
    expect(item["unit_price"]).to eq("491.21")
  end

  it "can find multiple items with case insensitive search" do
    item = Fabricate(:item, name: "item name")

    get "/api/v1/items/find_all?name=#{item.name.upcase}"

    response_item = JSON.parse(response.body)
    expect(response).to be_success
    expect(response_item.first["name"]).to eq(item.name)
    expect(response_item.first["description"]).to eq(item.description)
    expect(response_item.first["unit_price"]).to eq("0.15")
    expect(response_item.first["merchant_id"]).to eq(item.merchant_id)
  end

  it "can find a random item" do
    items = Fabricate.times(4, :item)

    get "/api/v1/items/random.json"
    random_item = JSON.parse(response.body)

    expect(response).to be_success
    items.one? { |item| item.id == random_item["id"] }
  end
end
