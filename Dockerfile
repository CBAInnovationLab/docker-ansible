FROM ubuntu:xenial

MAINTAINER dan.turner@cba.com.au

ENV DEBIAN_FRONTEND=noninteractive

COPY ./ansible /root/ansible

RUN apt-get update && \
    apt-get install -y ansible && \
    
    # Execute ansible
    cd /root/ansible && \
    ansible-playbook nginx.yml && \
    cd / && \
    
    # Clean up
    rm -rf /root/ansible && \
    apt-get remove -y ansible && \
    rm -rf /var/lib/apt/lists/*

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80 443
