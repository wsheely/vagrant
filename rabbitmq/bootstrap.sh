#!/usr/bin/env bash
set -e

if [ "$EUID" -ne "0" ]
then
  echo "Script must be run as root." >&2
  exit 1
fi

if which puppet > /dev/null
then
  echo "Puppet is already installed"
  exit 0
fi

echo "Running yum update...this might take a few minutes..."
yum -y update -q
echo "yum update complete!"

echo "Installing Puppet for CentOS 6.6..."
rpm -ivh --quiet http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
echo "Installing puppet agent..."
yum -y install puppet -q
echo "Puppet installed!"
