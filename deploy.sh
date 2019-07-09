docker build -t alexcraigs/multi-client:latest -t alexcraigs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexcraigs/multi-server:latest -t alexcraigs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexcraigs/multi-worker:latest -t alexcraigs/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push alexcraigs/multi-client:latest
docker push alexcraigs/multi-server:latest
docker push alexcraigs/multi-worker:latest

docker push alexcraigs/multi-client:$SHA
docker push alexcraigs/multi-server:$SHA
docker push alexcraigs/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alexcraigs/multi-server:$SHA
kubectl set image deployments/client-deployment client=alexcraigs/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alexcraigs/multi-worker:$SHA