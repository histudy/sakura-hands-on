require 'spec_helper'

describe yumrepo('remi-safe') do
  it { should be_enabled }
end
describe yumrepo('remi') do
  it { should be_enabled }
end
