FROM jenkins

MAINTAINER santiago

USER root

RUN apt-get update
RUN apt-get install -y wget unzip default-jdk libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1

ENV ANDROID_SDK_FILENAME android-sdk_r24.4.1-linux.tgz
ENV ANDROID_SDK_URL http://dl.google.com/android/${ANDROID_SDK_FILENAME}

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

WORKDIR /opt

RUN wget -q ${ANDROID_SDK_URL}
RUN tar -xzf ${ANDROID_SDK_FILENAME}
RUN rm ${ANDROID_SDK_FILENAME}

RUN echo y | android update sdk --no-ui -a --filter tools
RUN echo y | android update sdk --no-ui -a --filter platform-tools
RUN echo y | android update sdk --no-ui -a --filter android-24
RUN echo y | android update sdk --no-ui -a --filter build-tools-24.0.2
RUN echo y | android update sdk --no-ui -a --filter extra-google-google_play_services
RUN echo y | android update sdk --no-ui -a --filter extra-google-m2repository
RUN echo y | android update sdk --no-ui -a --filter extra-android-m2repository
RUN echo y | android update sdk --no-ui -a --filter build-tools-24.0.1
RUN echo y | android update sdk --no-ui -a --filter build-tools-24.0.0

USER jenkins
