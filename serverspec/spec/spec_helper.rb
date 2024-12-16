require 'serverspec'
require 'net/ssh'

set :backend, :ssh

host = ENV['TARGET_HOST']
options = Net::SSH::Config.for(host) 
options[:keys] = ['~/.ssh/id_rsa']
options[:user] ||= 'ec2-user'

set :host, host       
set :ssh_options, options

# Disable sudo
set :disable_sudo, true

# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'
