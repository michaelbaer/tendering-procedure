#!/bin/bash

export CHANNEL_NAME=tenderchannel

CATFILE_ORDERER=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/tender.com/orderers/orderer.tender.com/msp/tlscacerts/tlsca.tender.com-cert.pem

# announcer.com
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/announcer.com/users/Admin@announcer.com/msp

# create and join channel on peer0.announcer.com
export CORE_PEER_ADDRESS=peer0.announcer.com:7051
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/announcer.com/peers/peer0.announcer.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/announcer.com/peers/peer0.announcer.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/announcer.com/peers/peer0.announcer.com/tls/ca.crt

echo "Create Channel"
peer channel create -o orderer.tender.com:7050 -c $CHANNEL_NAME -f ../channel-artifacts/channel.tx --tls $CORE_PEER_TLS_ENABLED --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/tender.com/orderers/orderer.tender.com/msp/tlscacerts/tlsca.tender.com-cert.pem

echo "Join Channel on peer0.announcer.com"
peer channel join -b $CHANNEL_NAME.block

echo "Join anchor peer for announcer.com"
peer channel update -o orderer.tender.com:7050 -c $CHANNEL_NAME -f ../channel-artifacts/AnnouncerOrgAnchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $CATFILE_ORDERER

# join channel on peer1.announcer.com

export CORE_PEER_ADDRESS=peer1.announcer.com:7051

export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/announcer.com/peers/peer1.announcer.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/announcer.com/peers/peer1.announcer.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/announcer.com/peers/peer1.announcer.com/tls/ca.crt

echo "Join Channel on peer1.announcer.com"
peer channel join -b $CHANNEL_NAME.block


# bidder1.com
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/users/Admin@bidder1.com/msp
export CORE_PEER_LOCALMSPID="Bidder1MSP"

# join channel on peer0.bidder1.com
export CORE_PEER_ADDRESS=peer0.bidder1.com:7051
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/peers/peer0.bidder1.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/peers/peer0.bidder1.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/peers/peer0.bidder1.com/tls/ca.crt

echo "Join Channel on peer0.bidder1.com"
peer channel join -b $CHANNEL_NAME.block

echo "Join anchor peer for bidder1.com"
peer channel update -o orderer.tender.com:7050 -c $CHANNEL_NAME -f ../channel-artifacts/Bidder1OrgAnchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $CATFILE_ORDERER


# join channel on peer0.bidder1.com
export CORE_PEER_ADDRESS=peer1.bidder1.com:7051
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/peers/peer1.bidder1.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/peers/peer1.bidder1.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bidder1.com/peers/peer1.bidder1.com/tls/ca.crt

echo "Join Channel on peer1.bidder1.com"
peer channel join -b $CHANNEL_NAME.block


# evaluator1.com
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/evaluator1.com/users/Admin@evaluator1.com/msp
export CORE_PEER_LOCALMSPID="Evaluator1MSP"

# join channel on peer0.evaluator1.com
export CORE_PEER_ADDRESS=peer0.evaluator1.com:7051
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/evaluator1.com/peers/peer0.evaluator1.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/evaluator1.com/peers/peer0.evaluator1.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/evaluator1.com/peers/peer0.evaluator1.com/tls/ca.crt

echo "Join Channel on peer0.evaluator1.com"
peer channel join -b $CHANNEL_NAME.block

echo "Join anchor peer for evaluator1.com"
peer channel update -o orderer.tender.com:7050 -c $CHANNEL_NAME -f ../channel-artifacts/Evaluator1OrgAnchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $CATFILE_ORDERER

# join channel on peer0.evaluator1.com
export CORE_PEER_ADDRESS=peer1.evaluator1.com:7051
export CORE_PEER_TLS_CERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/evaluator1.com/peers/peer1.evaluator1.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/evaluator1.com/peers/peer1.evaluator1.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/evaluator1.com/peers/peer1.evaluator1.com/tls/ca.crt

echo "Join Channel on peer1.evaluator1.com"
peer channel join -b $CHANNEL_NAME.block


