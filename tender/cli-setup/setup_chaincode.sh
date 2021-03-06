#!/bin/bash

export CHANNEL_NAME=tenderchannel

CATFILE_ORDERER=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/tender.com/orderers/orderer.tender.com/msp/tlscacerts/tlsca.tender.com-cert.pem

NAME_CHAINCODE=tenderingChaincode
VERSION_CHAINCODE=0.14
PWD=`pwd`
# FOLDER_CHAINCODE=/opt/gopath/src/github.com/hyperledger/fabric/peer/chaincode/sample/ --> https://stackoverflow.com/questions/38472750/hyperledger-custom-chaincode-deployment-error
# FOLDER_CHAINCODE=github.com/hyperledger/fabric/peer/chaincode/sample/

FOLDER_CHAINCODE=github.com/hyperledger/fabric/peer/chaincode/tendering/

echo $FOLDER_CHAINCODE

# announcer.com
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/announcer.com/users/Admin@announcer.com/msp
# export CORE_PEER_MSPCONFIGPATH=github.com/hyperledger/fabric/peer/crypto/peerOrganizations/announcer.com/users/Admin@announcer.com/msp

export CORE_PEER_LOCALMSPID="AnnouncerMSP"

# create and join channel on peer0.announcer.com
export CORE_PEER_ADDRESS=peer0.announcer.com:7051
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/announcer.com/peers/peer0.announcer.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/announcer.com/peers/peer0.announcer.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/announcer.com/peers/peer0.announcer.com/tls/ca.crt

peer chaincode install -n $NAME_CHAINCODE -v $VERSION_CHAINCODE -p $FOLDER_CHAINCODE



# instantiate chaincode
CORE_PEER_TLS_ENABLED=true
# peer chaincode instantiate -o orderer.tender.com:7050 --tls $CORE_PEER_TLS_ENABLED --cafile $CATFILE_ORDERER -C $CHANNEL_NAME -n $NAME_CHAINCODE -v $VERSION_CHAINCODE -c '{"Args":[]}' -P "OR ('AnnouncerMSP.member')"


# update chaincode
peer chaincode upgrade -o orderer.tender.com:7050 --tls $CORE_PEER_TLS_ENABLED --cafile $CATFILE_ORDERER -C $CHANNEL_NAME -n $NAME_CHAINCODE -v $VERSION_CHAINCODE -c '{"Args":[]}'




# install chaincode on peer0.bidder.com
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/users/Admin@bidder1.com/msp
export CORE_PEER_LOCALMSPID="Bidder1MSP"

export CORE_PEER_ADDRESS=peer0.bidder1.com:7051
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/peers/peer0.bidder1.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/peers/peer0.bidder1.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/peers/peer0.bidder1.com/tls/ca.crt

peer chaincode install -n $NAME_CHAINCODE -v $VERSION_CHAINCODE -p $FOLDER_CHAINCODE

export CORE_PEER_ADDRESS=peer1.bidder1.com:7051
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/peers/peer1.bidder1.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/peers/peer1.bidder1.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/peers/peer1.bidder1.com/tls/ca.crt

peer chaincode install -n $NAME_CHAINCODE -v $VERSION_CHAINCODE -p $FOLDER_CHAINCODE