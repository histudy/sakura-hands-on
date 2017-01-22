require 'spec_helper'

property['apache_packages'].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe file(property['apache_vhost_dir']) do
  it { should exist }
  it { should be_directory }
end

property['apache_vhosts'].each do |vhostSetting|
  vhostConfigName = vhostSetting.key?('name') ? vhostSetting['name'] : vhostSetting['server_name']
  vhostStatus = vhostSetting.key?('state') ? vhostSetting['state'] : true
  describe file(property['apache_vhost_dir'] + '/' + vhostConfigName + '.conf') do
    if vhostStatus
      it { should exist }
      it { should be_file }
      it { should contain "ServerName #{vhostSetting['server_name']}" }
      if vhostSetting.key?('doc_root')
        it { should contain "DocumentRoot #{vhostSetting['doc_root']}" }
        it { should contain "<Directory #{vhostSetting['doc_root']}>" }
      end
    else
      it { should_not exist }
    end
  end
end

describe service('httpd') do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

if property['apache_packages'].include?('mod_ssl')
  describe port(443) do
    it { should be_listening }
  end
end
