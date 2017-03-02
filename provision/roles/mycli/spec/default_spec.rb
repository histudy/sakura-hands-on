require 'spec_helper'

describe package('mycli') do
  it { should be_installed.by('pip') }
end
