docker build -t trojshawn/multi-client:latest -t trojshawn/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t trojshawn/multi-server:latest -t trojshawn/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t trojshawn/multi-worker:latest -t trojshawn/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push trojshawn/multi-client:latest
docker push trojshawn/multi-client:$SHA
docker push trojshawn/multi-server:latest
docker push trojshawn/multi-server:$SHA
docker push trojshawn/multi-worker:latest
docker push trojshawn/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=trojshawn/multi-client:$SHA
kubectl set image deployments/server-deployment server=trojshawn/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=trojshawn/multi-worker:$SHA