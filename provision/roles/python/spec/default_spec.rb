require 'spec_helper'

%w{python-devel python-setuptools python2-pip}.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end
