#
# Cookbook Name:: ubuntu_base
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'ubuntu_base::default' do
  context 'When all attributes are default, on Ubuntu 16.04 platform' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe)
    end

    it 'converges successfully and configures cron_d' do
      expect { chef_run }.to_not raise_error
      expect(chef_run).to create_cron_d('auto_updates').with(
        minute: '0',
        hour: '0',
        weekday: '0',
        command: %w{
          echo "**************" >> /var/log/apt-security-updates
          date >> /var/log/apt-security-updates
          aptitude update >> /var/log/apt-security-updates
          aptitude safe-upgrade -o Aptitude::Delete-Unused=false --assume-yes --target-release `lsb_release -cs`-security >> /var/log/apt-security-updates
          echo "Security updates (if any) installed"
        }.join(' '),
        user: 'root'
      )
    end
  end
end
