FROM openjdk:11-jre-slim

WORKDIR /app

ADD ./target/bias-explorer-0.0.1-SNAPSHOT.jar app.jar 

EXPOSE 8081

ENTRYPOINT ["java","-jar"]

CMD ["app.jar"]