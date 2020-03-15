set -x

# Elevate priviledges, retaining the environment.
sudo -E su

# Install dev tools.
yum install -y "@Development Tools" python2-pip openssl-devel python-devel gcc libffi-devel httpd-tools

# Get the OKD 3.11 installer.
git clone -b release-3.11 https://github.com/openshift/openshift-ansible --depth=1
