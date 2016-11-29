# # encoding: utf-8

# Inspec test for recipe ubuntu_base::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe file('/etc/cron.d/auto_updates') do
  it { should be_file }
  it { should exist }
end
