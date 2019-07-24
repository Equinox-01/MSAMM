# frozen_string_literal: true

require_relative '../../algorithm/lehmer'
require_relative '../../algorithm/chart'

RSpec.describe Algorithm::Chart do
  let(:params) { [3, 5, 1] }

  subject do
    sequence = Algorithm::Lehmer.new(params[0], params[1], params[2]).sequence
    described_class.new(sequence).build_chart
  end

  it 'check chart' do
    expect(subject.count).to eq(20)
    expect(subject.class).to eq(Hash)
  end
end
