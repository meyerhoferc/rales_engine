require 'rails_helper'

describe "Customer API" do
  it "sends a list of customers" do

    customers = Fabricate.times(4, :customer)

    get '/api/v1/customers'

    expect(response).to be_success
    customer = JSON.parse(response.body)

    expect(customers.count).to eq(4)
  end
  it "can find one specific Customer" do
    id = Fabricate(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)
    expect(response).to be_success
    expect(customer["id"]).to eq(id)
  end

  it "can get a customer from first_name" do
    customer_one = Fabricate(:customer)
    customer_two = Fabricate(:customer, first_name: "Customer Two")

    get "/api/v1/customers/find?first_name=#{customer_one.first_name}"

    customer = JSON.parse(response.body)
    expect(response).to be_success
    expect(customer["first_name"]).to eq(customer_one.first_name)
    expect(customer["id"]).to eq(customer_one.id)
    expect(customer["first_name"]).to_not eq(customer_two.first_name)
    expect(customer["id"]).to_not eq(customer_two.id)
  end

  it "can get a customer from id" do
    customer_one = Fabricate(:customer)
    customer_two = Fabricate(:customer, first_name: "Customer Two")

    get "/api/v1/customers/find?id=#{customer_one.id}"

    customer = JSON.parse(response.body)
    expect(response).to be_success
    expect(customer["first_name"]).to eq(customer_one.first_name)
    expect(customer["id"]).to eq(customer_one.id)
    expect(customer["first_name"]).to_not eq(customer_two.first_name)
    expect(customer["id"]).to_not eq(customer_two.id)
  end

  it "can find random customer" do
    customer = Fabricate.times(4, :customer)
    get "/api/v1/customers/random.json"

    random_customer = JSON.parse(response.body)
    expect(response).to be_success
    customer.one? { |customer| customer.first_name == random_customer["first_name"] }
  end
end
