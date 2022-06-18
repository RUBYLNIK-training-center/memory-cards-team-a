require "rails_helper"
#
# RSpec.describe 'errors', type: :controller do
#   describe "not_found" do
#     it "GET #most_viewed renders #not_found.html template if html requested" do
#       get :not_found, :format => 'html'
#       response.should render_template('not_found')
#     end
#   end
# end

RSpec.describe ErrorsController do
  describe 'not_found' do
    before do
      get :not_found, format: :html
    end
    it "testing response" do
    expect(response).to render_template(:not_found)
    end
  end

  describe 'unacceptable' do
    before do
      get :unacceptable, format: :html
    end
    it "testing response" do
      expect(response).to render_template(:unacceptable)
    end
  end

  describe 'internal_error' do
    before do
      get :internal_error, format: :html
    end
    it "testing response" do
      expect(response).to render_template(:internal_error)
    end
  end
end