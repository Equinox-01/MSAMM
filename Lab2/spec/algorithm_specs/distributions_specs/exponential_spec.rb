# frozen_string_literal: true

require_relative '../../../algorithm/distributions/exponential.rb'
require 'descriptive_statistics'

RSpec.describe Algorithm::Distribution::Exponential do
  let(:rate) { 1 }

  subject do
    described_class.new('rate' => rate)
  end

  it 'check exponential distribution sequence output' do
    expect(subject.sequence.count).to eq(1_000_000)
    expect(subject.sequence).to all(be_an(Float))
  end

  context 'check stats for exponential distribution' do
    it 'check math_value' do
      expect(subject.sequence.mean.round(4)).to eq(1.001)
    end
    it 'check dispersion' do
      expect(subject.sequence.variance.round(4)).to eq(1.0023)
    end
    it 'check standard_deviation' do
      expect(subject.sequence.standard_deviation.round(4)).to eq(1.0012)
    end
  end
end
