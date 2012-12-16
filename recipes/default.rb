#
# Cookbook Name:: sonarsource
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "runit"

unless FileTest.exists?(node[:sonarsource][:install_path])
  remote_file "jira" do
    path "/tmp/sonar.zip"
    source "http://dist.sonar.codehaus.org/sonar-#{node[:sonarsource][:version]}.zip"
  end

  bash "unzip-sonar" do
    code "(cd /tmp; unzip /tmp/sonar.zip)"
  end
  
  bash "install-sonar" do
    code "mv /tmp/sonar-#{node[:sonarsource][:version]} #{node[:sonarsource][:install_path]}"
  end
end

runit_service "sonarsource"
