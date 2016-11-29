#
# Cookbook Name:: ubuntu_base
# Recipe:: default
#
# Copyright (c) 2016 Chris Maher, All Rights Reserved.

cron_d 'auto_updates' do
  minute  '0'
  hour    '0'
  weekday '0'
  command %w{
    echo "**************" >> /var/log/apt-security-updates
    date >> /var/log/apt-security-updates
    aptitude update >> /var/log/apt-security-updates
    aptitude safe-upgrade -o Aptitude::Delete-Unused=false --assume-yes --target-release `lsb_release -cs`-security >> /var/log/apt-security-updates
    echo "Security updates (if any) installed"
  }.join(' ')
  user 'root'
end
