sudo apt update
sudo apt upgrade

cd /workspaces/
curl https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.9-stable.tar.xz -O
tar xf flutter_linux_3.13.9-stable.tar.xz
rm flutter_linux_3.13.9-stable.tar.xz


apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform
terraform -help
touch ~/.bashrc
terraform -install-autocomplete



sudo wget -P /workspaces https://dl.google.com/go/go1.21.3.linux-amd64.tar.gz 

sudo rm -rf /workspaces/go && sudo tar -C /workspaces -xzf /workspaces/go1.21.3.linux-amd64.tar.gz
export PATH=$PATH:/workspaces/go/bin