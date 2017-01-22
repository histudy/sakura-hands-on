# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'sakura'

Vagrant.configure("2") do |config|
  config.vm.box = "dummy"
  config.vm.box_url = 'https://github.com/tsahara/vagrant-sakura/raw/master/dummy.box'

  config.ssh.pty = true

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "ansible_local" do |ansible|
    ansible.provisioning_path = "/vagrant/provision"
    ansible.playbook = "LAMP.yml"
  end

  ansibleVars = {
    "domain": "example.com"
  }
  groupVariableFile = File.expand_path(File.join(File.dirname(__FILE__), 'provision/group_vars/all.yml'))
  if File.exist?(groupVariableFile)
    ansibleVars.merge!(YAML.load_file(groupVariableFile))
  end
  hostVariableFile = File.expand_path(File.join(File.dirname(__FILE__), 'provision/host_vars/default.yml'))
  if File.exist?(hostVariableFile)
    ansibleVars.merge!(YAML.load_file(hostVariableFile))
  end

  # vagrant-hostmanager
  if Vagrant.has_plugin?('vagrant-hostmanager')
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.aliases = [
      'www.' + ansibleVars['domain'],
      'db.' + ansibleVars['domain'],
      'mailcatcher.' + ansibleVars['domain'],
    ]
  end

  config.vm.provider :sakura do |sakura, override|

    sakura.access_token = ENV['SAKURACLOUD_ACCESS_TOKEN'] || 'YOUR ACCESS TOKEN'
    sakura.access_token_secret = ENV['SAKURACLOUD_ACCESS_TOKEN_SECRET'] || 'YOUR ACCESS TOKEN SECRET'

    # サーバ名
    sakura.server_name = ansibleVars['domain']

    # ゾーン一覧
    # ```
    # curl --user "${SAKURACLOUD_ACCESS_TOKEN}":"${SAKURACLOUD_ACCESS_TOKEN_SECRET}"  \
    #   https://secure.sakura.ad.jp/cloud/zone/tk1v/api/cloud/1.1/zone | \
    #   jq -c ".Zones[] | {Name:.Name, Description: .Description}"
    # ```
    sakura.zone_id = ENV['SAKURACLOUD_ZONE'] || 'is1b'

    # アーカイブ一覧
    # ```
    # curl --user "${SAKURACLOUD_ACCESS_TOKEN}":"${SAKURACLOUD_ACCESS_TOKEN_SECRET}"  \
    #   https://secure.sakura.ad.jp/cloud/zone/${SAKURACLOUD_ZONE}/api/cloud/1.1/archive | \
    #   jq -c ".Archives[] | {ID:.ID, Name: .Name}"
    # ```
    sakura.disk_source_archive = '112801122159'

    # サーバプラン一覧
    # ```
    # curl --user "${SAKURACLOUD_ACCESS_TOKEN}":"${SAKURACLOUD_ACCESS_TOKEN_SECRET}"  \
    #   https://secure.sakura.ad.jp/cloud/zone/${SAKURACLOUD_ZONE}/api/cloud/1.1/product/server | \
    #   jq -c ".ServerPlans[] | {ID: .ID,Name:.Name, CPU: .CPU, MemoryMB: .MemoryMB}"
    # ```
    sakura.server_plan = 1001

    # ディスクプラン一覧
    # ```
    # curl --user "${SAKURACLOUD_ACCESS_TOKEN}":"${SAKURACLOUD_ACCESS_TOKEN_SECRET}"  \
    #   https://secure.sakura.ad.jp/cloud/zone/${SAKURACLOUD_ZONE}/api/cloud/1.1/product/disk | \
    #   jq -c ".DiskPlans[] | {ID: .ID,Name:.Name}"
    # ```
    # sakura.disk_plan = 4

    # SSHキー一覧
    # ```
    # curl -s --user "${SAKURACLOUD_ACCESS_TOKEN}":"${SAKURACLOUD_ACCESS_TOKEN_SECRET}" \
    #   https://secure.sakura.ad.jp/cloud/zone/${SAKURACLOUD_ZONE}/api/cloud/1.1/sshkey | \
    #   jq -c ".SSHKeys[] | {ID: .ID, Name:.Name}"
    # ```
    sakura.sshkey_id = '0123456789'

    override.ssh.username = "root"
    override.ssh.private_key_path = File.expand_path("~/.ssh/vagrant")
  end
end
