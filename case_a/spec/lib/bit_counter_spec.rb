require 'spec_helper'

describe BitCounter::Parser do
  let!(:sample_file) { File.join(File.dirname(__FILE__), 'sample_files/sample.png') }
  subject { BitCounter::Parser.new(sample_file) }

  describe '#zero_count' do
    it 'returns correct number of zeros' do
      expect(subject.zero_count).to eq(4690)
    end
  end

  describe '#one_count' do
    it 'returns correct number of ones' do
      expect(subject.one_count).to eq(2486)
    end
  end
end