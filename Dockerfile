FROM sonatype/nexus:oss

ARG NEXUS_VERSION=2.14.5-02

USER root

RUN yum install -y unzip \
 yum clean all

# install nexus-p2-repository-plugin
RUN curl --fail --silent --location --retry 3 \
    -o /tmp/nexus-p2-repository-plugin-${NEXUS_VERSION}-bundle.zip \
    https://repo1.maven.org/maven2/org/sonatype/nexus/plugins/nexus-p2-repository-plugin/${NEXUS_VERSION}/nexus-p2-repository-plugin-${NEXUS_VERSION}-bundle.zip \
  && unzip -d /opt/sonatype/nexus/nexus/WEB-INF/plugin-repository \
    /tmp/nexus-p2-repository-plugin-${NEXUS_VERSION}-bundle.zip \
  && find /opt/sonatype/nexus/nexus/WEB-INF/plugin-repository/nexus-p2-repository-plugin-${NEXUS_VERSION} \
    -type d -exec chmod 755 {} \; \
  && find /opt/sonatype/nexus/nexus/WEB-INF/plugin-repository/nexus-p2-repository-plugin-${NEXUS_VERSION} \
    -type f -exec chmod 644 {} \; \
  && rm /tmp/nexus-p2-repository-plugin-${NEXUS_VERSION}-bundle.zip

# install nexus-p2-bridge-plugin
RUN curl --fail --silent --location --retry 3 \
    -o /tmp/nexus-p2-bridge-plugin-${NEXUS_VERSION}-bundle.zip \
    https://repo1.maven.org/maven2/org/sonatype/nexus/plugins/nexus-p2-bridge-plugin/${NEXUS_VERSION}/nexus-p2-bridge-plugin-${NEXUS_VERSION}-bundle.zip \
  && unzip -d /opt/sonatype/nexus/nexus/WEB-INF/plugin-repository \
    /tmp/nexus-p2-bridge-plugin-${NEXUS_VERSION}-bundle.zip \
  && find /opt/sonatype/nexus/nexus/WEB-INF/plugin-repository/nexus-p2-bridge-plugin-${NEXUS_VERSION} \
    -type d -exec chmod 755 {} \; \
  && find /opt/sonatype/nexus/nexus/WEB-INF/plugin-repository/nexus-p2-bridge-plugin-${NEXUS_VERSION} \
    -type f -exec chmod 644 {} \; \
  && rm /tmp/nexus-p2-bridge-plugin-${NEXUS_VERSION}-bundle.zip

#incresea maximum memory for java to at least 2048 (recommended for p2 plugin)
RUN sed -i -E "s/wrapper.java.maxmemory=([0-9]*)/wrapper.java.maxmemory=2048/" /opt/sonatype/nexus/bin/jsw/conf/wrapper.conf

RUN curl --fail --silent --location --retry 3 \
    -o /tmp/nexus-unpack-plugin-${NEXUS_VERSION}-bundle.zip \
    https://repo1.maven.org/maven2/org/sonatype/nexus/plugins/nexus-unpack-plugin/${NEXUS_VERSION}/nexus-unpack-plugin-${NEXUS_VERSION}-bundle.zip \
  && unzip -d /opt/sonatype/nexus/nexus/WEB-INF/plugin-repository \
    /tmp/nexus-unpack-plugin-${NEXUS_VERSION}-bundle.zip \
  && find /opt/sonatype/nexus/nexus/WEB-INF/plugin-repository/nexus-unpack-plugin-${NEXUS_VERSION} \
    -type d -exec chmod 755 {} \; \
  && find /opt/sonatype/nexus/nexus/WEB-INF/plugin-repository/nexus-unpack-plugin-${NEXUS_VERSION} \
    -type f -exec chmod 644 {} \; \
  && rm /tmp/nexus-unpack-plugin-${NEXUS_VERSION}-bundle.zip

USER nexus
