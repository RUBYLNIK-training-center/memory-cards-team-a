require 'rails_helper'

RSpec.describe InstructionsController, type: :routing do
  describe 'routing' do
    it 'routes to #manual' do
      expect(get: '/manual').to route_to('instractions#manual')
    end
  end
end
