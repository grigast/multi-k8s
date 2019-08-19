docker build -t grigatr/multi-client:latest -t grigatr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t grigatr/multi-server:latest -t grigatr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t grigatr/multi-worker:latest -t grigatr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push grigatr/multi-client:latest
docker push grigatr/multi-server:latest
docker push grigatr/multi-worker:latest

docker push grigatr/multi-client:$SHA
docker push grigatr/multi-server:$SHA
docker push grigatr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=grigatr/multi-server:$SHA
kubectl set image deploymnets/client-deployment client=grigatr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=grigatr/multi-worker:$SHA
