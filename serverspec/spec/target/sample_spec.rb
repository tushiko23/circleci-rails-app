require 'spec_helper'

# Circleci環境では、ssコマンドが使えないので、"/bin/sh -c ss\ -tunl\ \|\ grep\ -E\ --\ :80\\\"になり,jobが失敗する。
# なので、Circleciのジョブでssコマンドが使えるパッケージをインストールしてから実行。
describe port("80") do
  it { should be_listening }
end

%w{git make gcc-c++ patch libyaml-devel libffi-devel libicu-devel zlib-devel readline-devel libxml2-devel libxslt-devel ImageMagick ImageMagick-devel openssl-devel libcurl libcurl-devel curl}.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe command('npm list webpack') do
  let(:disable_sudo) { true }
  its(:stdout) { should match(/webpack/) }
end

describe command('npm list webpack-cli') do
  let(:disable_sudo) { true }
  its(:stdout) { should match(/webpack-cli/) }
end

# PATHを指定しないと、/home/ec2-user/.rbenv/versionsディレクトリ下でテストするので、インストールしたパス/home/ec2-user/.rbenv/shimsディレクトリ下を指定してあげる
describe command('ruby -v') do
  let(:disable_sudo) { true }
  let(:path) { '/home/ec2-user/.rbenv/shims:$PATH' }
  its(:stdout) { should match /ruby 3\.2\.3/ }
end

# PATHを指定しないと、/home/ec2-user/.rbenv/versionsディレクトリ下でテストするので、インストールしたパス/home/ec2-user/.rbenv/shimsディレクトリ下を指定してあげる
describe command('bundler --version') do
  let(:disable_sudo) { true }
  let(:path) { '/home/ec2-user/.rbenv/shims:$PATH' }
  its(:stdout) { should match /Bundler version 2\.4\.19/ }
end

describe command('yarn --version') do
  let(:disable_sudo) { true }
  its(:stdout) { should match /^1\.22\.19/ }
end

# PATHを指定しないと、/home/ec2-user/.rbenv/versionsディレクトリ下でテストするので、インストールしたパス/home/ec2-user/.rbenv/shimsディレクトリ下を指定してあげる
describe command('rails --version') do
  let(:disable_sudo) { true }
  let(:path) { '/home/ec2-user/.rbenv/shims:$PATH' }
  its(:stdout) { should match /^Rails 7\.1\.3\.2$/ }
end

describe command('node --version') do
  let(:disable_sudo) { true }
  its(:stdout) { should match /^v17\.9\.1$/ }
end

describe package('nginx') do
it { should be_installed }
end

# PATHを指定しないと、/home/ec2-user/.rbenv/versionsディレクトリ下でテストするので、インストールしたパス/home/ec2-user/.rbenv/shimsディレクトリ下を指定してあげる
describe command('gem list puma -i ') do
  let(:disable_sudo) { true }
  let(:path) { '/home/ec2-user/.rbenv/shims:$PATH' }
  its(:stdout) { should match(/true/) }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe service('puma') do
  it { should be_enabled }
  it { should be_running }
end

describe command('curl http://127.0.0.1:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^200$/ }
end

# 設定したドメインでHTTP通信がHTTPS通信にリダイレクトされるステータス301を返すかも確認
describe command('curl http://tushiko23-tech.com:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^301$/ }
end

# default sample
#require 'spec_helper'

#describe package('httpd'), :if => os[:family] == 'redhat' do
#  it { should be_installed }
#end

#describe package('apache2'), :if => os[:family] == 'ubuntu' do
#  it { should be_installed }
#end

#describe service('httpd'), :if => os[:family] == 'redhat' do
#  it { should be_enabled }
#  it { should be_running }
#end

#describe service('apache2'), :if => os[:family] == 'ubuntu' do
#  it { should be_enabled }
#  it { should be_running }
#end

#describe service('org.apache.httpd'), :if => os[:family] == 'darwin' do
#  it { should be_enabled }
#  it { should be_running }
#end

#describe port(80) do
#  it { should be_listening }
#end
