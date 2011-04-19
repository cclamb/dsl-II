require_relative '../../lib/insomnia/artifact'

describe 'define' do

  class TestArtifact < Artifact
    attr_accessor :attributes
  end

  it 'should accept a single hash value' do
    artifact = TestArtifact.new do
      define :bar => 'bar'
    end
    artifact.attributes.should include(:bar)
  end

  it 'should accept multiple single hash values' do
    artifact = TestArtifact.new do
      define :bar => 'bar'
      define :foo => 'foo'
    end
    artifact.attributes.should include(:bar, :foo)
  end

  it 'should accept multiple hash values' do
    artifact = TestArtifact.new do
      define :bar => 'bar', :foo => 'foo'
    end
    artifact.attributes.should include(:bar, :foo)
  end

  it 'should not accept anything but a hash' do
    has_error = false
    begin
      artifact = Artifact.new do
        define [1,2,4]
      end
    rescue TypeError
      has_error = true
    end
    has_error.should == true
  end
end

