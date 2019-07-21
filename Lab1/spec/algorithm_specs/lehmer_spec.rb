# frozen_string_literal: true

require_relative '../../algorithm/lehmer'

RSpec.describe Algorithm::Lehmer do
  let(:params) { [3, 1, 5] }

  subject do
    described_class.new(params[0], params[1], params[2])
  end

  it 'check Lehmer sequence' do
    expect(subject.sequence.count).to eq(1_000_000)
    expect(subject.sequence).to all(be_an(Float))
  end
end
