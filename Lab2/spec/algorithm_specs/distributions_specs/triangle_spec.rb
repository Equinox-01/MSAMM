# frozen_string_literal: true

require_relative '../../../algorithm/distributions/triangle.rb'
require 'descriptive_statistics'

RSpec.describe Algorithm::Distribution::Triangle do
  let(:a) { 10 }
  let(:b) { 20 }

  subject do
    described_class.new('a' => a, 'b' => b)
  end

  it 'check triangle distribution sequence output' do
    expect(subject.sequence.count).to eq(999_999)
    expect(subject.sequence).to all(be_an(Float))
  end

  context 'check stats for triangle distribution' do
    it 'check math_value' do
      expect(subject.sequence.mean.round(4)).to eq(16.6653)
    end
    it 'check dispersion' do
      expect(subject.sequence.variance.round(4)).to eq(5.5807)
    end
    it 'check standard_deviation' do
      expect(subject.sequence.standard_deviation.round(4)).to eq(2.3623)
    end
  end
end
