require 'rails_helper'

RSpec.describe HighlightHelper, type: :helper do
  describe '#markdown' do
    it 'returns correct format of markdown' do
      expect(markdown('- here we go')).to eq("<ul>\n<li>here we go</li>\n</ul>\n")
    end
  end

  describe 'CodeRayify' do
    describe '#markdown' do
      let(:answer) do
        "<div class=\"CodeRay\">\n  <div class=\"code\"><pre>let" \
          " i = <span style=\"color:#00D\">5</span></pre></div>\n</div>\n"
      end

      it 'returns block of code' do
        expect(HighlightHelper::CodeRayify.new.block_code('let i = 5', 'javascript')).to eq(answer)
      end
    end
  end
end
