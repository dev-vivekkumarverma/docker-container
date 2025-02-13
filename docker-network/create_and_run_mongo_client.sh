# create and run mongo client in the docker container name mongo client in interactive shell mode.
# It should connect to the mongo host container named db running on port 27017 on network named app-net


docker run --name=mongo_client -it --network=app-net --rm mongo:3 mongo --host db