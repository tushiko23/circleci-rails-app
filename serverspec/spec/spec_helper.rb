require 'serverspec'
require 'net/ssh'

#set :backend, :ssh
#config_file = File.expand_path('/home/circleci/project/.ssh/config') 
#host = ENV['TARGET_HOST_NAME']
#options = Net::SSH::Config.load(config_file, host)
#options = Net::SSH::Config.for(host) 
# options[:keys] = ['~/.ssh/id_rsa']
#options[:user] ||= 'ec2-user'
#puts "DEBUG: TARGET_HOST_NAME = #{ENV['TARGET_HOST_NAME']}"
#puts "DEBUG: SSH config for host: #{Net::SSH::Config.for(ENV['TARGET_HOST_NAME']).inspect}"

#set :host, host       
#set :ssh_options, options

# Disable sudo
#set :disable_sudo, true

# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
#set :path, '/sbin:/usr/bin/ss:$PATH'
# set :path, '/home/circleci/bin:/home/circleci/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH'

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
set :path, '/sbin:/usr/local/sbin:/.ssh/config:/usr/bin/ss:$PATH'
