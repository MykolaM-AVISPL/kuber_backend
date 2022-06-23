FROM openjdk:17.0.2-oracle
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

ENV JAVA_OPTIONS \
-XX:+UseContainerSupport \
-XX:InitialRAMPercentage=15.0 \
-XX:+UseStringDeduplication \
-XX:+UseG1GC \
-XX:MaxGCPauseMillis=200 \
-Djava.net.preferIPv4Stack=true \
-Dfile.encoding=UTF-8 \
-XX:-OmitStackTraceInFastThrow \
-XX:+PrintConcurrentLocks \
--add-opens=java.base/java.lang=ALL-UNNAMED \
--add-opens=java.base/java.io=ALL-UNNAMED \
--add-opens=java.base/java.util=ALL-UNNAMED \
--add-opens=java.base/java.util.concurrent=ALL-UNNAMED \
--add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED \
--add-opens=java.base/java.lang.invoke=ALL-UNNAMED

# optional to allow adding new options from outside without redefining all default options, only ones you want to add
ENV JAVA_OPTIONS_EXT ""

ENV SPRING_BOOT_OPTION "-Dspring.config.location=classpath:/application.yml"
ENV SPRING_BOOT_OPTION_EXT ""

# exec would force sh process to be replaced by java process,
# eliminating parent process hanging in process tree doing nothing
ENTRYPOINT ["sh", "-c","exec java $JAVA_OPTIONS $JAVA_OPTIONS_EXT -jar /app.jar $SPRING_BOOT_OPTION $SPRING_BOOT_OPTION_EXT"]
