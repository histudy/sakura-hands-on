require 'spec_helper'

property['dehydrated_dependency_packages'].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe file('/usr/local/src/dehydrated') do
  it { should exist }
  it { should be_directory }
end

describe file('/usr/local/bin/dehydrated') do
  it { should exist }
  it { should be_file }
  it { should be_symlink }
  it { should be_linked_to '/usr/local/src/dehydrated/dehydrated' }
end
describe file('/etc/dehydrated') do
  it { should exist }
  it { should be_directory }
end
describe file('/etc/dehydrated/config') do
  it { should exist }
  it { should be_file }
  property['dehydrated_cfg'].each do |key, value|
    its(:content) { should match /^#{key.upcase}="#{Regexp.escape(value)}"/ }
  end
end
