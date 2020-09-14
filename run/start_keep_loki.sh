# example: export $KEEP_CLIENT_ETHEREUM_PASSWORD="1234"
if [[ -z $KEEP_CLIENT_ETHEREUM_PASSWORD ]]; then
	echo "please export KEEP_CLIENT_ETHEREUM_PASSWORD"
	exit 1;
fi

# example: export KEEP_CLIENT_DOCKER_IMAGE=keepnetwork/keep-client:v1.2.0-rc
if [[ -z $KEEP_CLIENT_DOCKER_IMAGE ]]; then
	echo "please export KEEP_CLIENT_DOCKER_IMAGE"
	exit 1;
fi

sudo docker stop keep-client
sudo docker rm keep-client
sudo docker images -a | grep "keep-client" | awk '{print $3}' | xargs sudo docker rmi
sudo docker pull $KEEP_CLIENT_DOCKER_IMAGE

sudo docker run -dit \
--restart always \
--volume $HOME/keep-client:/mnt \
--env KEEP_ETHEREUM_PASSWORD=$KEEP_CLIENT_ETHEREUM_PASSWORD \
--env LOG_LEVEL=debug \
--log-opt max-size=100m \
--log-opt max-file=3 \
--log-driver loki \
--log-opt loki-url="http://136.244.109.187:3100/loki/api/v1/push" \
--name keep-client \
-p 3919:3919 -p 8080:8080 -p 8081:8081 \
$KEEP_CLIENT_DOCKER_IMAGE --config /mnt/config/config.toml start
