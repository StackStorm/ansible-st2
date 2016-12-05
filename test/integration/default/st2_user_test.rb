# encoding: utf-8
# author: Javier Palomo Almena

describe group('stanley') do
  it { should exist }
end

describe user('stanley') do
  it { should exist }
  its('group') { should eq 'stanley' }
  its('home') { should eq '/home/stanley' }
end

describe passwd.users(/stanley/) do
  its('homes') { should eq ['/home/stanley'] }
end

describe directory('/home/stanley/.ssh') do
  it { should exist }
  its('owner') { should eq 'stanley' }
  its('group') { should eq 'stanley' }
  it { should be_readable.by('owner') }
  it { should_not be_readable.by('group') }
  it { should be_writable.by('owner') }
  it { should_not be_writable.by('group') }
  it { should be_executable.by('owner') }
  it { should_not be_executable.by('group') }
end

describe file('/home/stanley/.ssh/stanley_rsa') do
  it { should exist }
  its('owner') { should eq 'stanley' }
  its('group') { should eq 'stanley' }
  it { should be_readable.by('owner') }
  it { should_not be_readable.by('group') }
  it { should be_writable.by('owner') }
  it { should_not be_writable.by('group') }
  it { should_not be_executable.by('owner') }
  it { should_not be_executable.by('group') }
end

describe file('/home/stanley/.ssh/stanley_rsa.pub') do
  it { should exist }
  its('owner') { should eq 'stanley' }
  its('group') { should eq 'stanley' }
  it { should be_readable.by('owner') }
  it { should be_readable.by('group') }
  it { should be_readable }
  it { should be_writable.by('owner') }
  it { should_not be_writable.by('group') }
  it { should_not be_executable.by('owner') }
  it { should_not be_executable.by('group') }
end

describe file('/home/stanley/.ssh/authorized_keys') do
  it { should exist }
  its('owner') { should eq 'stanley' }
  its('group') { should eq 'stanley' }
  it { should be_readable.by('owner') }
  it { should_not be_readable.by('group') }
  it { should be_readable }
  it { should be_writable.by('owner') }
  it { should_not be_writable.by('group') }
  it { should_not be_executable.by('owner') }
  it { should_not be_executable.by('group') }
end

describe file('/etc/sudoers.d/st2') do
  it { should exist }
  its('content') { should match(%r{stanley\s.*?ALL\=\(ALL\)\s.*?NOPASSWD:\s.*?SETENV:\s.*?ALL}) }
end
