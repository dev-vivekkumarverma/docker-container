docker run --init --rm \
    --name volume_access_tracker_container \
    --mount type=volume,source=python_data_volume,target=/data_folder \
    python-volume-access-tracter