require 'rails_helper'

describe "Merchant Record API" do
  it "sends a list of merchants" do
    Fabricate.times(4, :merchant)

    get '/api/v1/merchants'
    expect(response).to be_success
    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(4)
  end

  it "can get an individual merchant from id" do
    id = Fabricate(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)
    expect(response).to be_success
    expect(merchant["id"]).to eq(id)
  end

  it "can get a merchant from name" do
    merchant_one = Fabricate(:merchant)
    merchant_two = Fabricate(:merchant, name: "Merchant Two")

    get "/api/v1/merchants/find?name=#{merchant_one.name}"

    merchant = JSON.parse(response.body)
    expect(response).to be_success
    expect(merchant["name"]).to eq(merchant_one.name)
    expect(merchant["id"]).to eq(merchant_one.id)
    expect(merchant["name"]).to_not eq(merchant_two.name)
    expect(merchant["id"]).to_not eq(merchant_two.id)
  end

  it "can find merchant from id" do
    merchant_one = Fabricate(:merchant)
    merchant_two = Fabricate(:merchant, name: "Merchant Two")

    get "/api/v1/merchants/find?id=#{merchant_one.id}"

    merchant = JSON.parse(response.body)
    expect(response).to be_success
    expect(merchant["name"]).to eq(merchant_one.name)
    expect(merchant["id"]).to eq(merchant_one.id)
    expect(merchant["name"]).to_not eq(merchant_two.name)
    expect(merchant["id"]).to_not eq(merchant_two.id)
  end

  it "can find multiple merchants" do
    merchant_one = Fabricate(:merchant, name: "Merchant")
    merchant_two = Fabricate(:merchant, name: "Merchant")

    get "/api/v1/merchants/find_all?name=Merchant"

    merchants = JSON.parse(response.body)
    expect(response).to be_success
    expect(merchants.class).to eq(Array)

    expect(merchants.count).to eq(2)
    expect(merchants.first["name"]).to eq("Merchant")
    expect(merchants.last["name"]).to eq("Merchant")
  end

  it "can find a random merchant" do
    merchants = Fabricate.times(4, :merchant)

    get "/api/v1/merchants/random.json"
    random_merchant = JSON.parse(response.body)

    expect(response).to be_success
    merchants.one? { |merchant| merchant.name == random_merchant["name"] }
  end
end
