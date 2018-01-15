#!/bin/bash

export CHANNEL_NAME=tenderchannel

CATFILE_ORDERER=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/tender.com/orderers/orderer.tender.com/msp/tlscacerts/tlsca.tender.com-cert.pem

NAME_CHAINCODE=mytestchaincode
VERSION_CHAINCODE=1.0
PWD=`pwd`
FOLDER_CHAINCODE=/opt/gopath/src/github.com/hyperledger/fabric/peer/chaincode/sample/

echo $FOLDER_CHAINCODE

# announcer.com
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/announcer.com/users/Admin@announcer.com/msp

# create and join channel on peer0.announcer.com
export CORE_PEER_ADDRESS=peer0.announcer.com:7051
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/announcer.com/peers/peer0.announcer.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/announcer.com/peers/peer0.announcer.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/announcer.com/peers/peer0.announcer.com/tls/ca.crt

peer chaincode install -n $NAME_CHAINCODE -v $VERSION_CHAINCODE -p $FOLDER_CHAINCODE



/opt/gopath/src/github.com/hyperledger/fabric/peer/