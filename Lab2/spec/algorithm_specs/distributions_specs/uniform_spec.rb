# frozen_string_literal: true

require_relative '../../../algorithm/distributions/uniform.rb'
require 'descriptive_statistics'

RSpec.describe Algorithm::Distribution::Uniform do
  let(:a) { 10 }
  let(:b) { 20 }

  subject do
    described_class.new('a' => a, 'b' => b)
  end

  it 'check uniform distribution sequence output' do
    expect(subject.sequence.count).to eq(1_000_000)
    expect(subject.sequence).to all(be_an(Float))
  end

  context 'check stats for uniform distribution' do
    it 'check math_value' do
      expect(subject.sequence.mean.round(4)).to eq(14.9998)
    end
    it 'check dispersion' do
      expect(subject.sequence.variance.round(4)).to eq(8.3545)
    end
    it 'check standard_deviation' do
      expect(subject.sequence.standard_deviation.round(4)).to eq(2.8904)
    end
  end
end
