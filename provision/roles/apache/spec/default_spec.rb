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
  describe file(property['apache_conf_dir'] + '/ssl.conf') do
    it { should exist }
    it { should be_file }
    sslConfig = property['apache_ssl_cfg'];
    its(:content) { should match /^SSLPassPhraseDialog #{Regexp.escape(sslConfig['pass_phrase_dialog'])}/ }
    its(:content) { should match /^SSLSessionCache #{Regexp.escape(sslConfig['session_cache'])}/ }
    its(:content) { should match /^SSLSessionCacheTimeout #{sslConfig['session_cache_timeout']}/ }
    sslConfig['random_seed'].each do |randomSeed|
      its(:content) { should match /^SSLRandomSeed #{randomSeed['context']} #{Regexp.escape(randomSeed['source'])} #{randomSeed['bytes']}/ }
    end
    its(:content) { should match /^SSLCryptoDevice #{sslConfig['crypto_device']}/ }
    its(:content) { should match /^SSLProtocol #{sslConfig['protocol'].join(' ')}/ }
    its(:content) { should match /^SSLCipherSuite #{sslConfig['cipher_suite'].join(':')}/ }
    its(:content) { should match /^SSLHonorCipherOrder #{sslConfig['honor_cipher_order'] ? 'on' : 'off'}/ }
    its(:content) { should match /^SSLCompression #{sslConfig['compression'] ? 'on' : 'off'}/ }
    if sslConfig.key?('options')
      its(:content) { should match /^SSLCipherSuite #{sslConfig['options'].join(' ')}/ }
    end
    its(:content) { should match /^SSLUseStapling #{sslConfig['use_stapling'] ? 'on' : 'off'}/ }
    its(:content) { should match /^SSLStaplingResponderTimeout #{sslConfig['stapling_responder_timeout']}/ }
    its(:content) { should match /^SSLStaplingReturnResponderErrors #{sslConfig['stapling_return_responder_errors'] ? 'on' : 'off'}/ }
    its(:content) { should match /^SSLStaplingCache #{Regexp.escape(sslConfig['stapling_cache'])}/ }
  end
  describe port(443) do
    it { should be_listening }
  end
end
