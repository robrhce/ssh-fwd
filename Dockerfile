FROM ubuntu:jammy

RUN apt-get update && apt-get install -y openssh-client && apt-get install -y wget
SHELL ["/bin/bash", "-c"]

# here are some default values (can be overwritten by an env.txt for instance)
ENV SSHKEY_FILE=ha-tunnel.key
ENV SSHKEY_PATH=/home/rob/.keys/
ENV TUNNEL_HOST=127.0.0.1
ENV LOCAL_PORT=8123
ENV REMOTE_HOST=13.237.69.213
ENV REMOTE_PORT=8123
ENV SGU_KEY=update-key-here

VOLUME $SSHKEY_PATH/SSHKEY_FILE /home/ssh/ssh.key
CMD wget https://sgu.aws.rhce.com.au/?key=$SGU_KEY &&  ssh -4 -o StrictHostKeyChecking=no -o ExitOnForwardFailure=yes -i /home/ssh/ssh.key -l ec2-user -R *:$REMOTE_PORT:127.0.0.1:$LOCAL_PORT $REMOTE_HOST && bash

