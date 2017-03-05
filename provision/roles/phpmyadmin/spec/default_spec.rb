require 'spec_helper'

describe package('phpMyAdmin') do
  it { should be_installed }
end

describe file(property['phpmyadmin_upload_dir']) do
  it { should exist }
  it { should be_directory }
end
describe file(property['phpmyadmin_save_dir']) do
  it { should exist }
  it { should be_directory }
end

describe file('/etc/httpd/conf.d/phpMyAdmin.conf') do
  it { should_not exist }
end

describe file('/etc/phpMyAdmin/config.inc.php') do
  it { should exist }
  it { should be_file }
end
