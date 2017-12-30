require 'spec_helper'
describe 'profie' do
  context 'with default values for all parameters' do
    it { should contain_class('profile') }
  end
end
