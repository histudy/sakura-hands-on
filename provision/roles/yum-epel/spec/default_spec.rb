require 'spec_helper'

describe yumrepo('epel') do
  it { should be_enabled }
end
