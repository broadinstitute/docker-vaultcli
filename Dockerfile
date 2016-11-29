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

# install consul-template
RUN curl -sf -o consul.zip https://releases.hashicorp.com/consul-template/0.16.0/consul-template_0.16.0_linux_amd64.zip && \
    unzip consul.zip -d /usr/local/bin/ && \
    rm -f consul.zip && \
    chmod 0755 /usr/local/bin/* && \
    rm -rf /tmp/*  /var/tmp/*

COPY lib/vault_loader.py /lib/vault_loader.py
COPY bin/vaultenv /bin/vaultenv
COPY bin/configure /bin/configure
COPY bin/configure_remote /bin/configure_remote
COPY bin/render_properties /bin/render_properties

# configure shared volume for passing secrets between containers
RUN mkdir secret_share
VOLUME /secret_share

RUN chmod +x /bin/vaultenv
RUN chmod +x /bin/configure
RUN chmod +x /bin/render_properties

ENV VAULT_ADDR https://clotho.broadinstitute.org:8200