require "rails_helper"

RSpec.describe 'Welcome', :type => :request do
  describe "GET index" do
    it "has a 200 status code" do
      get 'http://localhost:3000/'
      expect(response.status).to eq(200)
    end
  end
end