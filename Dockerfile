FROM ubuntu:16.04

LABEL version="1.0"
LABEL maintainer="dozcan@gmail.com"

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --yes software-properties-common
RUN add-apt-repository ppa:ethereum/ethereum
RUN apt-get update && apt-get install --yes geth


RUN adduser --disabled-login --gecos "" blockchain
COPY eth_common /home/blockchain/eth_common
#after copying eth_common folder to new container
#change its  owner to  eth_user for recursive for subfolders
RUN chown -R blockchain:blockchain /home/blockchain/eth_common
USER blockchain
#after inspecting container our first directory will be
#eth_common 
WORKDIR /home/blockchain/eth_common

RUN geth init genesis.json
ENTRYPOINT ["./setup_account.sh"]

