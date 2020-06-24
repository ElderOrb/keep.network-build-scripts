geth account new --keystore keep-ecdsa-operator-account.keystore.dir --password keep-ecdsa-operator-account-password.txt
mv keep-ecdsa-operator-account.keystore.dir/* ./keep-ecdsa-operator-account.keystore
rm -rf keep-ecdsa-operator-account.keystore.dir

# get some eth from ropsten faucet
ECDSA_PUBLIC_KEY=$(grep -Po '"address": *\K"[^"]*"' keep-ecdsa-operator-account.keystore | sed 's/"//g')
wget https://faucet.ropsten.be/donate/0x$ECDSA_PUBLIC_KEY > nul

# get some keep from keep faucet
wget https://us-central1-keep-test-f3e0.cloudfunctions.net/keep-faucet-ropsten?account=0x$ECDSA_PUBLIC_KEY > nul

# now import keystore to metamask and go to dashboard https://dashboard.test.keep.network/