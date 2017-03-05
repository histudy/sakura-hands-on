require 'spec_helper'

property['lexicon_dependency_packages'].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

property['lexicon_dependency_pip_packages'].each do |pkg|
  describe package(pkg) do
    it { should be_installed.by('pip') }
  end
end

if property['lexicon_install_dehydrated_hook']
  describe file(property['lexicon_hook_dest']) do
    it { should exist }
    it { should be_file }
  end
end
