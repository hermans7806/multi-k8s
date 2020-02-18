docker build -t chrono5/multi-client:latest -t chrono5/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chrono5/multi-server:latest -t chrono5/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chrono5/multi-worker:latest -t chrono5/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push chrono5/multi-client:latest
docker push chrono5/multi-server:latest
docker push chrono5/multi-worker:latest
docker push chrono5/multi-client:$SHA
docker push chrono5/multi-server:$SHA
docker push chrono5/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chrono5/multi-server:$SHA
kubectl set image deployments/client-deployment client=chrono5/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chrono5/multi-worker:$SHA