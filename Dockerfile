FROM amazoncorretto:22-alpine3.19-jdk AS buildtools


ARG SPIGOT_REV

ENV BUILDTOOLS_URL https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

WORKDIR /tmp/build

RUN apk --no-cache update
RUN apk --no-cache add --virtual dependencies git curl
RUN curl -O "${BUILDTOOLS_URL}"
RUN java -jar BuildTools.jar --rev "${SPIGOT_REV}"
RUN apk del dependencies

CMD [ "/bin/sh" ]
