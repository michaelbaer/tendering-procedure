# tendering-procedure
Hyperledger fabric example project for a tendering procedure

STILL IN PROGRESS

# tendering-procedure
Hyperledger fabric example project for a tendering procedure

## Getting started

### Prerequisites
The following tools have to be installed on your operating system:

* Vagrant
* VirtualBox
* VirtualBox Guest Additions

The easiest way for me to install VirtualBox Guest Additions was to install the vagrant-vbguest plugin.
```
vagrant plugin install vagrant-vbguest
```
### Next steps

Start vagrant and ssh into the vm
```
vagrant up
vagrant ssh
```
Generate needed crypto stuff, configuration channel transaction and peer transactions.
```
cd tender
./setup.sh
```
## The network

* 1xOrderer
* 1xAnnouncer organization with 2 peers
* 1xBidder organization with 2 peers
* 1xEvaluator organization with 2 peers
