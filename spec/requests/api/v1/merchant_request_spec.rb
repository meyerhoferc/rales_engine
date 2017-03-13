require 'rails_helper'

describe "Merchant API" do
  it "sends a list of merchants" do
    merchants = Fabricate.times(4, :merchant)

    get '/api/v1/merchants'

    expect(response).to be_success
    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(4)
  end
end
