require 'rails_helper'

describe "Invoice APi" do
  it "sends a list of invoices" do
    invoices = Fabricate.times(4, :invoice)

    get "/api/v1/invoices"

    expect(response).to be_success
    invoices = JSON.parse(response.body)
    expect(invoices.count).to eq(4)
  end
end
