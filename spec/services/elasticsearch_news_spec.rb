# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ElasticsearchNews do
  let(:query) { 'scott' }
  let(:before) { 1_554_037_199_999 }
  let(:after) { 1_551_358_800_000 }
  let(:interval) { '1' }
  let(:service) { described_class.new(query: query, before: before, after: after, interval: interval) }

  describe '#initialize' do
    it 'initialize the service' do
      expect(service.query).to eq('scott')
      expect(service.before).to eq(1_554_037_199_999)
      expect(service.after).to eq(1_551_358_800_000)
      expect(service.interval).to eq('1')
    end
  end
end
