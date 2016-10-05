FROM jenkins

MAINTAINER santiago

USER root

RUN apt-get update
RUN apt-get install -y \
    curl \
    default-jdk \
    lib32gcc1 \
    lib32ncurses5 \
    lib32stdc++6 \
    lib32z1 \
    libc6-i386 \
    unzip

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

WORKDIR /opt

RUN curl http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz | tar -xz

COPY licenses android-sdk-linux/licenses

RUN chown -R jenkins:jenkins /opt/android-sdk-linux

USER jenkins

# The following SDK packages are needed; the rest are dynamically installed since Android Gradle plugin 2.2
RUN echo y | android update sdk --no-ui -a --filter extra-android-m2repository,extra-google-google_play_services,extra-google-m2repository,platform-tools
