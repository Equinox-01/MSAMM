# frozen_string_literal: true

require_relative '../../algorithm/chart'

RSpec.describe Algorithm::Chart do
  let(:sequence) { 1_000_000.times.map { rand 0.0..1.0 } }

  subject do
    described_class.new(sequence).build_chart
  end

  it 'check chart' do
    expect(subject.count).to eq(20)
    expect(subject.class).to eq(Hash)
  end
end
