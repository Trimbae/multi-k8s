docker build -t mtrimby/multi-client:latest -t mtrimby/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mtrimby/multi-server:latest -t mtrimby/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mtrimby/multi-worker:latest -t mtrimby/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mtrimby/multi-client:latest
docker push mtrimby/multi-server:latest
docker push mtrimby/multi-worker:latest

docker push mtrimby/multi-client:$SHA
docker push mtrimby/multi-server:$SHA
docker push mtrimby/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mtrimby/multi-server:$SHA
kubectl set image deployments/client-deployment client=mtrimby/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mtrimby/multi-worker:$SHA