require 'rails_helper'

RSpec.describe InstructionsController, type: :routing do
  describe 'routing' do
    it 'routes to #manual' do
      expect(get: '/instructions').to route_to('instructions#manual')
    end
  end
end
