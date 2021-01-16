kubectl create namespace voting

kubectl label namespace voting istio-injection=enabled

kubectl apply -f step-1-create-voting-app.yaml --namespace voting

kubectl apply -f step-1-create-voting-app-gateway.yaml --namespace voting