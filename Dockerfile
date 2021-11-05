FROM openjdk:11-jre

RUN apt-get update && apt-get install -y \
  mysql-client

ENV	HIBISCUS_VERSION 2.10.0

RUN curl -fsSL https://www.willuhn.de/products/hibiscus-server/releases/hibiscus-server-$HIBISCUS_VERSION.zip -o hibiscus-server.zip
RUN unzip hibiscus-server.zip -d /
RUN rm hibiscus-server.zip

RUN echo "Europe/Berlin" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

COPY ./docker-entrypoint.sh /
COPY ./create-tables.sh /
COPY ./policy /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8080
