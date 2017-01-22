require 'spec_helper'

describe package('mailcatcher') do
  it { should be_installed.by('gem') }
end
describe service('mailcatcher') do
  it { should be_enabled }
  it { should be_running }
end
describe port(property['mailcatcher_cfg']['http']['port']) do
  it { should be_listening }
end
describe port(property['mailcatcher_cfg']['smtp']['port']) do
  it { should be_listening }
end
