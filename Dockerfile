FROM openjdk:13-jdk-alpine
ADD ./target/spring-rest-hello-world-1.0.jar app.jar
EXPOSE 8080
CMD ["java", "-jar","app.jar"]