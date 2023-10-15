cd /workspaces/
curl https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.5-stable.tar.xz -O
tar xf flutter_linux_3.13.5-stable.tar.xz
rm flutter_linux_3.13.5-stable.tar.xz

sudo apt-get install terraform
terraform -help
touch ~/.bashrc
terraform -install-autocomplete