FROM openjdk:8

# install python
RUN apt-get update && \
    apt-get install python3.4 python-pip python-virtualenv -y && \
    apt-get install -y maven
RUN pip install hvac

# install vault
RUN curl -sf -o vault.zip  https://releases.hashicorp.com/vault/0.6.1/vault_0.6.1_linux_amd64.zip && \
    unzip vault.zip -d /usr/local/bin/ && \
    rm -f vault.zip && \
    chmod 0755 /usr/local/bin/* && \
    rm -rf /tmp/* /var/tmp/*

COPY lib/vault_loader.py /lib/vault_loader.py
COPY bin/vaultenv /bin/vaultenv
COPY bin/configure /bin/configure
COPY bin/configure_remote /bin/configure_remote

RUN chmod +x /bin/vaultenv
RUN chmod +x /bin/configure

ENV VAULT_ADDR https://clotho.broadinstitute.org:8200