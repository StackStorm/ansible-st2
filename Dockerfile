# This Dockerfile is a temporary solution so that we can test our centos
# images until https://github.com/test-kitchen/kitchen-docker/pull/253/files is merged and released.
# Once that fix is available, this Dockerfile and all references to it in .kitchen.yml should be removed.

# This Dockerfile was generated by modifying the Ruby source for the Docker driver for kitchen in the same way
# @arma did in the upstream kitchen repository, printed the resulting output to the console, and pasted the result here.
# This should help ensure this Dockerfile is accurate to what the driver will do once that PR merges.

FROM stackstorm/packagingtest:centos7

ENV container docker
RUN yum clean all
RUN yum install -y sudo openssh-server openssh-clients which curl
RUN [ -f "/etc/ssh/ssh_host_rsa_key" ] || ssh-keygen -A -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN [ -f "/etc/ssh/ssh_host_dsa_key" ] || ssh-keygen -A -t dsa -f /etc/ssh/ssh_host_dsa_key

RUN if ! getent passwd kitchen; then                 useradd -d /home/kitchen -m -s /bin/bash -p '*' kitchen;               fi
RUN echo "kitchen ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "Defaults !requiretty" >> /etc/sudoers
RUN mkdir -p /home/kitchen/.ssh
RUN chown -R kitchen /home/kitchen/.ssh
RUN chmod 0700 /home/kitchen/.ssh
RUN touch /home/kitchen/.ssh/authorized_keys
RUN chown kitchen /home/kitchen/.ssh/authorized_keys
RUN chmod 0600 /home/kitchen/.ssh/authorized_keys

RUN echo ssh-rsa\ AAAAB3NzaC1yc2EAAAADAQABAAABAQCU8pQuW7WoLAh4\+om7Kaw3uYZrTx14\+pBD80nmNFtzOc6QMhjtjLvvvorijIGOAmmdMyBrhDhy6Q/nJVNQufwR3MSq6\+wwiM65O9gckDjT5MUO7Bat8PFf0KyR9Kq5iJ1Z69KAN7sBULJFRxIAbA\+Q4czb16a7EDN9yqfMv9SgcI7e\+Evm5IV/S\+3\+65QtVdn9sfz2ca2rsSeCeWbPpl3isA7IdqqD6sDMff7tPWBbzg8zRRg95TJSjafQat4MzP5bQVOT3wxEcL\+/lsvrMEZ2omGn86biTfCw04Csnb2BZ30fVRL6OolUVnSmVeBQ2bBykYDYpBtZWGfjBNIz29dj\ kitchen_docker_key >> /home/kitchen/.ssh/authorized_keys