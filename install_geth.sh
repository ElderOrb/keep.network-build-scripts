echo $SUDOPWD | sudo -S add-apt-repository -y ppa:ethereum/ethereum
echo $SUDOPWD | sudo -S apt-get update
echo $SUDOPWD | sudo -S apt-get install ethereum

