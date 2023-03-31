FROM maven:3.8.4-jdk-11-slim as builder
ADD . /src
WORKDIR /src
RUN mvn package

FROM alpine:3.15.3
RUN apk --no-cache add openjdk11-jre
COPY --from=builder /src/target/eureka-1.0-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
