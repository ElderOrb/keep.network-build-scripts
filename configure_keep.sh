# expects the following exports:
# KEEP_CLIENT_DIR - directory where keep was cloned 
# (or directory where config, persistence & keystore folders will be created)
if [[ -z $KEEP_CLIENT_DIR || -z $ETH_WSS || -z $ETH_HTTPS || -z $ETH_WALLET ]]; then

	if [[ -z $KEEP_CLIENT_DIR ]]; then
	  echo "please export KEEP_CLIENT_DIR"
	fi
	if [[ -z $ETH_WSS ]]; then
	  echo "please export ETH_WSS"
	fi
	if [[ -z $ETH_HTTPS ]]; then
	  echo "please export ETH_HTTPS"
	fi
	if [[ -z $ETH_WALLET ]]; then
	  echo "please export ETH_WALLET"
	fi

else

	mkdir -p $KEEP_CLIENT_DIR/config
	mkdir -p $KEEP_CLIENT_DIR/keystore
	mkdir -p $KEEP_CLIENT_DIR/persistence

	if [[ -z $KEEP_KEYSTORE_PATH ]]; then
	  KEEP_KEYSTORE_PATH=/mnt/keystore/keep_wallet.json
	  echo "KEEP_KEYSTORE_PATH not set, using default keystore path: $KEEP_KEYSTORE_PATH"
	else
	  echo "KEEP_KEYSTORE_PATH is set, using $KEEP_KEYSTORE_PATH"	
	fi

	if [[ -z $KEEP_PERSISTENCE_DIR ]]; then
	  KEEP_PERSISTENCE_DIR=/mnt/persistence
	  echo "KEEP_PERSISTENCE_DIR not set, using default persistence dir: $KEEP_PERSISTENCE_DIR"
	else
	  echo "KEEP_PERSISTENCE_DIR is set, using $KEEP_PERSISTENCE_DIR"	
	fi
	
	if [[ -z $KEEP_SERVER_IP ]]; then
	  echo "KEEP_SERVER_IP not set and will not be used"
	else
	  echo "KEEP_SERVER_IP is set, using $KEEP_SERVER_IP"	
	fi
	
	if [[ -z $KEEP_SERVER_PORT ]]; then
	  echo "KEEP_SERVER_PORT not set and will not be used"
	else
	  echo "KEEP_SERVER_PORT is set, using $KEEP_SERVER_PORT"	
	fi

	cat <<EOF >$KEEP_CLIENT_DIR/config_tmp.toml
# Ethereum host connection info.
[ethereum]
 URL = "$ETH_WSS"
 URLRPC = "$ETH_HTTPS"

# Keep operator Ethereum account.
[ethereum.account]
 Address = "$ETH_WALLET"
 KeyFile = "$KEEP_KEYSTORE_PATH"

# Keep contract addresses configuration.
[ethereum.ContractAddresses]
  KeepRandomBeaconOperator = "0x440626169759ad6598cd53558F0982b84A28Ad7a"
  TokenStaking = "0xEb2bA3f065081B6459A6784ba8b34A1DfeCc183A"
  KeepRandomBeaconService = "0xF9AEdd99357514d9D1AE389A65a4bd270cBCb56c"

# Keep network configuration.
[LibP2P]
 Peers = [
"/dns4/bootstrap-0.test.keep.network/tcp/3919/ipfs/16Uiu2HAmCcfVpHwfBKNFbQuhvGuFXHVLQ65gB4sJm7HyrcZuLttH",
"/dns4/bootstrap-1.test.keep.network/tcp/3919/ipfs/16Uiu2HAm3eJtyFKAttzJ85NLMromHuRg4yyum3CREMf6CHBBV6KY",
"/dns4/bootstrap-2.test.keep.network/tcp/3919/ipfs/16Uiu2HAmNNuCp45z5bgB8KiTHv1vHTNAVbBgxxtTFGAndageo9Dp",
"/dns4/bootstrap-3.test.keep.network/tcp/3919/ipfs/16Uiu2HAm8KJX32kr3eYUhDuzwTucSfAfspnjnXNf9veVhB12t6Vf",
"/dns4/bootstrap-4.test.keep.network/tcp/3919/ipfs/16Uiu2HAkxRTeySEWZfW9C83GPFpQUXvrygmZryCN6DL4piZrbAv4",
"/dns4/bootstrap-1.core.keep.test.boar.network/tcp/3001/ipfs/16Uiu2HAkuTUKNh6HkfvWBEkftZbqZHPHi3Kak5ZUygAxvsdQ2UgG",
"/dns4/bootstrap-2.core.keep.test.boar.network/tcp/3001/ipfs/16Uiu2HAmQirGruZBvtbLHr5SDebsYGcq6Djw7ijF3gnkqsdQs3wK"
]
EOF
	
	if [[ -n $KEEP_SERVER_IP && -n $KEEP_SERVER_PORT ]]; then
	cat <<EOF >>$KEEP_CLIENT_DIR/config_tmp.toml
Port = $KEEP_SERVER_PORT
 # Override the node’s default addresses announced in the network
 AnnouncedAddresses = ["/ip4/$KEEP_SERVER_IP/tcp/$KEEP_SERVER_PORT"]
EOF
	fi
	
	cat <<EOF >>$KEEP_CLIENT_DIR/config_tmp.toml

# Storage is encrypted
[Storage]
 DataDir = "$KEEP_PERSISTENCE_DIR"	
EOF

	mv $KEEP_CLIENT_DIR/config_tmp.toml $KEEP_CLIENT_DIR/config/config.toml
fi