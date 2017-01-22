require 'spec_helper'

describe file(property['phpmyadmin_dest']) do
  it { should exist }
  it { should be_directory }
end
describe file(property['phpmyadmin_dest'] + '/config.inc.php') do
  it { should exist }
  it { should be_file }
end
