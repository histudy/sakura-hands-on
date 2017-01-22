require 'spec_helper'

describe file('/usr/local/bin/wp') do
  it { should exist }
  it { should be_file }
  it { should be_executable }
end
describe file('/etc/bash_completion.d/wp') do
  it { should exist }
  it { should be_file }
end
