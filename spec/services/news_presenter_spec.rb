# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsPresenter do
  let(:presenter) { described_class.new(elasticsearch_hash) }
  let(:elasticsearch_hash) do
    {
      "aggregations": {
        "first_agg": {
          "buckets": [
            {
              "doc_count": 106_177,
              "key": 1_551_358_800_000,
              "key_as_string": '2019-08-01T00:00:00.000Z',
              "key": 1_564_617_600_000.0,
              "count_by_medium_type": { "doc_count_error_upper_bound": 0,
                                        "sum_other_doc_count": 0,
                                        "buckets": [{ "key": 'Online', "doc_count": 1 }] }
            }
          ]
        }
      }
    }.with_indifferent_access
  end

  describe '#initialize' do
    it 'initialize the presenter' do
      expect(presenter.elasticsearch_hash).to eq(elasticsearch_hash)
    end
  end

  describe '#present' do
    let(:expected_hash) do
      [{ name: '2019-08-01',
         online: 1,
         print: 0,
         radio: 0,
         social: 0,
         tv: 0 }]
    end

    it 'transform the hash into expected hash' do
      expect(presenter.present).to eq(expected_hash)
    end
  end
end
