require 'spec_helper'
describe 'racktables' do

  context 'with defaults for all parameters' do
    it { should contain_class('racktables') }
  end
end
