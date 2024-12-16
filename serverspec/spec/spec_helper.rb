require 'serverspec'
require 'net/ssh'

set :backend, :ssh

host = ENV['TARGET_HOST_NAME']
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
set :path, '/sbin:/usr/bin/ss:$PATH'
# set :path, '/home/circleci/bin:/home/circleci/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH'
