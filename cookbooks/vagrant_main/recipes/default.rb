apt_package 'curl'
apt_package 'git-core'

bash "install rvm system wide" do
  user 'root'
  code "bash < <( curl -L http://bit.ly/rvm-install-system-wide )"
end

['root', 'vagrant'].each do |user_name|
  bash "setup rvm for #{user_name}" do
    user user_name
    code <<-EOH
    echo '[[ -s "/usr/local/lib/rvm" ]] && . "/usr/local/lib/rvm"  # This loads RVM into a shell session.' >> ~/.profile
    EOH
  end
  
end

bash "add vagrant user to the rvm group" do
  user "root"
  code "usermod -a -G rvm vagrant"
end

bash "install ruby 1.9.2 and make it the default" do
  user 'root'
  code <<-EOH
  rvm install 1.9.2
  rvm --default 1.9.2
  EOH
end

# TODO: Installing correct ruby gems
# 1. Switch to system ruby
# 2. Get a list of the gems that are installed with versions
# 3. Switch back to ruby 1.9.2
# 4. Install all of the gems that were caputured