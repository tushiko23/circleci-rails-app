require 'serverspec'
require 'net/ssh'

set :backend, :ssh

#if ENV['ASK_SUDO_PASSWORD']
#  begin
#    require 'highline/import'
#  rescue LoadError
#    fail "highline is not available. Try installing it."
#  end
#  set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
#else
#  set :sudo_password, ENV['SUDO_PASSWORD']
#end

host = 'target' 
options = Net::SSH::Config.for(host) 
options[:keys] = ['~/.ssh/id_rsa']
options[:user] ||= 'ec2-user'
# options[:host_name] = '54.238.217.251'

set :host, host        
set :ssh_options, options

# Disable sudo
set :disable_sudo, true

# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'
