require "rails_helper"

RSpec.describe "User log in endpoint" do
  before(:each) do
    @user = User.create(email: "test@test.com", password: "test_password", password_confirmation: "test_password", api_key: "key")
  end

  it "logs in a user" do

    params = {
      "email": "test@test.com",
      "password": "test_password",
    }

    post "/api/v0/sessions", params: params.to_json, headers: {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

    data = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(data).to have_key(:type)
    expect(data[:type]).to eq("user")
    expect(data).to have_key(:id)
    expect(data[:id].to_i).to eq(@user.id)
    expect(data).to have_key(:attributes)
    expect(data[:attributes]).to have_key(:email)
    expect(data[:attributes][:email]).to eq("test@test.com")
    expect(data[:attributes]).to have_key(:api_key)
    expect(data[:attributes][:api_key]).to eq("key")
  end
end