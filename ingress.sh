az aks get-credentials --resource-group modpoc-CSP-rg --name modpoc-k8s



# Specify the Istio version that will be leveraged throughout these instructions
ISTIO_VERSION=1.7.6

curl -sL "https://github.com/istio/istio/releases/download/$ISTIO_VERSION/istioctl-$ISTIO_VERSION-linux-amd64.tar.gz" | tar xz

sudo mv ./istioctl /usr/local/bin/istioctl
sudo chmod +x /usr/local/bin/istioctl

# Generate the bash completion file and source it in your current shell
mkdir -p ~/completions && istioctl collateral --bash -o ~/completions
source ~/completions/istioctl.bash

# Source the bash completion file in your .bashrc so that the command-line completions
# are permanently available in your shell
echo "source ~/completions/istioctl.bash" >> ~/.bashrc

istioctl operator init

sleep 60

kubectl create ns istio-system

kubectl apply -f istio.aks.yaml

sleep 120


kubectl get all -n istio-system


export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo $INGRESS_HOST
# Public IP address of your ingress controller
export IP=$INGRESS_HOST

echo $IP 
# Name to associate with public IP address
DNSNAME="demo-modpoc-ingress"

# Get the resource-id of the public ip
PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$IP')].[id]" --output tsv)

echo $PUBLICIPID 

# Update public ip address with DNS name
az network public-ip update --ids $PUBLICIPID --dns-name $DNSNAME

# Display the FQDN
az network public-ip show --ids $PUBLICIPID --query "[dnsSettings.fqdn]" --output tsv