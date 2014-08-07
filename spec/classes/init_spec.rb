require 'spec_helper'
describe 'drupal' do

  context 'with defaults for all parameters' do
    it { should contain_class('drupal') }
  end
end
