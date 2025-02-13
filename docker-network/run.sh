# 1. create the network called app-net
./create_network.sh

# 2. host mongo db in the container called db at 27017 on app-net network and run in detach mode
./create_mongo_host.sh

# 3. create mongo client on the container called mongo_client on same network in interactive cli mode
./create_and_run_mongo_client.sh

# 4. delete the network called app-net
./delete_network.sh

# 5. delete the mongo host running in detached mode

docker container stop db
