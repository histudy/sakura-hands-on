require 'spec_helper'

property['php_packages'].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe file('/usr/local/bin/composer') do
  it { should exist }
  it { should be_file }
  it { should be_executable }
end

def get_ini_value(value)
  if value.kind_of?(TrueClass) || value.kind_of?(FalseClass)
    return value ? 'On' : 'Off'
  elsif value.nil?
      return ""
  else
    return value.to_s
  end
end

describe 'PHP config parameters' do
  describe file('/etc/php.ini') do
    property['php_cfg'].each do |key, value|
      if key != 'extra_parameters'
        if value.kind_of?(Hash)
          value.each do |subkey, subvalue|
            ini_value = Regexp.escape(get_ini_value(subvalue))
            if key + '.' + subkey == 'url_rewriter.tags'
              ini_value = '"' + ini_value + '"'
            end
            its(:content) { should match /^#{key}.#{subkey} = #{ini_value}/ }
          end
        else
          its(:content) { should match /^#{key} = #{Regexp.escape(get_ini_value(value))}/ }
        end
      else
        value.each do |section, settings|
          settings.each do |subkey, subvalue|
            its(:content) { should match /^#{section}.#{subkey} = #{Regexp.escape(get_ini_value(subvalue))}/ }
          end
        end
      end
    end
  end
end
