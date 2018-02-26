FROM xmartlabs/android AS android

FROM jenkins/jenkins
ENV ANDROID_HOME /opt/android-sdk-linux
COPY --from=android ${ANDROID_HOME} ${ANDROID_HOME}
COPY --from=android /usr/lib/jvm/java-8-oracle /usr/lib/jvm/java-8-oracle
COPY --from=android /usr/bin/gradle /usr/bin/gradle
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Unfortunately, "chown" flag seems not to be available for COPY in DockerHub.
USER root
RUN chown -R jenkins:jenkins ${ANDROID_HOME}
USER jenkins

ENV ANDROID_EMULATOR_FORCE_32BIT true
