FROM adoptopenjdk/openjdk11:jdk-11.0.11_9-debian-slim
ADD . /eo_graphs
WORKDIR /eo_graphs
RUN apt-get update -y && apt-get install time maven build-essential -y && scripts/compile.sh && \
    cat scripts/compare.sh >> scripts/start.sh && \
    cat scripts/test.sh >> scripts/start.sh && \
    chmod +x scripts/*.sh
ENTRYPOINT ["scripts/start.sh"]