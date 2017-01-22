require 'spec_helper'

property['mysql_packages'].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe file('/root/.my.cnf') do
  it { should exist }
  it { should be_file }
end

describe file('/etc/my.cnf.d') do
  it { should exist }
  it { should be_directory }
end

describe file('/etc/my.cnf') do
  it { should contain "!includedir /etc/my.cnf.d" }
end

%w{mysql client mysqld}.each  do |configName|
  describe file('/etc/my.cnf.d/' + configName + '.cnf') do
    it { should exist }
    it { should be_file }
  end
end

describe service('mysqld') do
  it { should be_enabled }
  it { should be_running }
end
describe port(3306) do
  it { should be_listening }
end
