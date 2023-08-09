FROM epay.harbor.com/library/maven:3.6.3-jdk-8 as builder
WORKDIR /app
COPY . .
COPY ./cicd/settings.xml settings.xml
RUN mvn clean install -DskipTests -Dmaven.wagon.http.ssl.insecure=true -U -B -s settings.xml
RUN ls /app/adapter/target
FROM epay.harbor.com/library/openjdk:8-jdk
WORKDIR /adapter
COPY --from=builder /app/adapter/target target
ENTRYPOINT ["java", "-jar", "/adapter/target/bidv-adapter-0.1.jar"]
