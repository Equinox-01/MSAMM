# frozen_string_literal: true

require_relative '../../algorithm/lehmer'
require_relative '../../algorithm/stats'

RSpec.describe Algorithm::Stats do
  let(:params) { [3, 5, 1] }

  subject do
    sequence = Algorithm::Lehmer.new(params[0], params[1], params[2]).sequence
    described_class.new(sequence)
  end

  context 'check statistic' do
    it 'check math_value' do
      expect(subject.expected).to eq(0.5)
    end
    it 'check dispersion' do
      expect(subject.dispersion.round(4)).to eq(0.05)
    end
    it 'check standard_deviation' do
      expect(subject.standard_deviation.round(4)).to eq(0.2236)
    end
    it 'check indirect_indications' do
      expect(subject.indirect_evaluation).to eq(0.5)
    end
    it 'check period_length' do
      expect(subject.period_length).to eq(4)
    end
    it 'check aperiodic_section_length' do
      expect(subject.aperiodicity).to eq(4)
    end
  end
end
