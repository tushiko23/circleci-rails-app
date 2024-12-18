require 'serverspec'
require 'net/ssh'

set :backend, :ssh
config_file = File.expand_path('~/.ssh/config') 
host = ENV['TARGET_HOST_NAME']
options = Net::SSH::Config.load(config_file, host)
#options = Net::SSH::Config.for(host) 
# options[:keys] = ['~/.ssh/id_rsa']
options[:user] ||= 'ec2-user'
puts "DEBUG: TARGET_HOST_NAME = #{ENV['TARGET_HOST_NAME']}"
puts "DEBUG: SSH config for host: #{Net::SSH::Config.for(ENV['TARGET_HOST_NAME']).inspect}"

set :host, host       
set :ssh_options, options

# Disable sudo
set :disable_sudo, true

# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
set :path, '/sbin:/usr/bin/ss:$PATH'
# set :path, '/home/circleci/bin:/home/circleci/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH'
