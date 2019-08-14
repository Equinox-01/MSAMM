# frozen_string_literal: true

require_relative '../../../algorithm/distributions/gaussian.rb'
require 'descriptive_statistics'

RSpec.describe Algorithm::Distribution::Gaussian do
  let(:mean) { 0 }
  let(:scale) { 1 }

  subject do
    described_class.new('mean' => mean, 'scale' => scale)
  end

  it 'check gaussian distribution sequence output' do
    expect(subject.sequence.count).to eq(1_000_000)
    expect(subject.sequence).to all(be_an(Float))
  end

  context 'check stats for gaussian distribution' do
    it 'check math_value' do
      expect(subject.sequence.mean.round(4)).to eq(-0.0002)
    end
    it 'check dispersion' do
      expect(subject.sequence.variance.round(4)).to eq(1.006)
    end
    it 'check standard_deviation' do
      expect(subject.sequence.standard_deviation.round(4)).to eq(1.003)
    end
  end
end
