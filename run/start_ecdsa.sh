# example: export $KEEP_ECDSA_ETHEREUM_PASSWORD="1234"
if [[ -z $KEEP_ECDSA_ETHEREUM_PASSWORD ]]; then
	echo "please export KEEP_ECDSA_ETHEREUM_PASSWORD"
	exit 1;
fi

# example: export KEEP_ECDSA_DOCKER_IMAGE=keepnetwork/keep-ecdsa-client:v1.0.0
if [[ -z $KEEP_ECDSA_DOCKER_IMAGE ]]; then
	echo "please export KEEP_ECDSA_DOCKER_IMAGE"
	exit 1;
fi

export KEEP_ECDSA_CONFIG_DIR=$HOME/keep-ecdsa/configs
export KEEP_ECDSA_PERSISTENCE_DIR=$HOME/keep-ecdsa/persistence

docker run -d \
--entrypoint /usr/local/bin/keep-ecdsa \
--volume $HOME/keep-ecdsa:/mnt \
--volume $KEEP_ECDSA_PERSISTENCE_DIR:/mnt/keep-ecdsa/persistence \
--volume $KEEP_ECDSA_CONFIG_DIR:/mnt/keep-ecdsa/config \
--name ecdsa-keep-client \
--env KEEP_ETHEREUM_PASSWORD=$KEEP_ECDSA_ETHEREUM_PASSWORD \
--env LOG_LEVEL=debug \
--log-opt max-size=100m \
--log-opt max-file=3 \
-p 3920:3920 \
$KEEP_ECDSA_DOCKER_IMAGE --config /mnt/keep-ecdsa/config/config.toml start

docker container ls --all
