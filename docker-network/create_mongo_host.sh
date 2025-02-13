# creating mongo host on docker-network named app-net
docker run --rm --init --name=db --network=app-net -p 27017:27017 -d mongo:3 

echo "mongo host is running in detach mode in the container named 'db' on port 27017 on network app-net"

