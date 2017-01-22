require 'spec_helper'

property['common_pachages'].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

%w{firewalld fail2ban}.each do |serviceName|
  describe service(serviceName) do
    it { should be_enabled }
    it { should be_running }
  end
end
