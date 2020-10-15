FROM apache/nifi:1.11.4

USER root

ENV NIFI_JVM_HEAP_INIT=2048m
ENV NIFI_JVM_HEAP_MAX=4096m

COPY nifi-start.sh ../scripts/nifi-start.sh

RUN \
    chmod +x ../scripts/nifi-start.sh && \
    apt install -y wget && \
    wget -c https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.20.tar.gz && \
    tar -xvzf mysql-connector-java-8.0.20.tar.gz && \
    mkdir -p /opt/nifi/nifi-current/external && \
    cp mysql-connector-java-8.0.20/mysql-connector-java-8.0.20.jar /opt/nifi/nifi-current/external && \
    chown -R nifi:nifi /opt/nifi/nifi-current/external && \
    chown -R nifi:nifi /opt/nifi/nifi-current/lib && \
    rm -f mysql-connector-java-8.0.20.tar.gz && \
    rm -fr mysql-connector-java-8.0.20

USER nifi

ENTRYPOINT ["../scripts/nifi-start.sh"]
