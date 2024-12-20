require 'serverspec'
require 'net/ssh'

set :backend, :ssh

if ENV['ASK_SUDO_PASSWORD']
  begin
    require 'highline/import'
  rescue LoadError
    fail "highline is not available. Try installing it."
  end
  set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
else
  set :sudo_password, ENV['SUDO_PASSWORD']
end

host = ENV['TARGET_HOST']

options = Net::SSH::Config.for(host)

options[:user] ||= Etc.getlogin

set :host,        options[:host_name] || host
set :ssh_options, options

# Disable sudo
# set :disable_sudo, true


# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
# $PATH内で.ssh/configを明示的に参照して、.ssh/config内の"Host <任意の名前>"の名前解決をする
# ssコマンド(ソケットの出力を確認するコマンド)を使えるようにインストールした場所のPATHを指定する
set :path, '/sbin:/usr/local/sbin:/.ssh/config:/usr/bin/ss:$PATH'
# Default PATH
# set :path, '/home/circleci/bin:/home/circleci/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH'
