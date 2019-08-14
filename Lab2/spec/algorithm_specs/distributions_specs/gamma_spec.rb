# frozen_string_literal: true

require_relative '../../../algorithm/distributions/gamma.rb'
require 'descriptive_statistics'

RSpec.describe Algorithm::Distribution::Gamma do
  let(:shape) { 3 }
  let(:scale) { 2 }

  subject do
    described_class.new('shape' => shape, 'scale' => scale)
  end

  it 'check gamma distribution sequence output' do
    expect(subject.sequence.count).to eq(1_000_000)
    expect(subject.sequence).to all(be_an(Float))
  end

  context 'check stats for gamma distribution' do
    it 'check math_value' do
      expect(subject.sequence.mean.round(4)).to eq(1.5015)
    end
    it 'check dispersion' do
      expect(subject.sequence.variance.round(4)).to eq(0.7531)
    end
    it 'check standard_deviation' do
      expect(subject.sequence.standard_deviation.round(4)).to eq(0.8678)
    end
  end
end
