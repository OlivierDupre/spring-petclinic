FROM openjdk:8-jdk-alpine
MAINTAINER Toulouse-JAM

ADD target/spring-petclinic-1.5.1.jar spring-petclinic-1.5.1.jar

ENTRYPOINT  ["java","-jar", "spring-petclinic-1.5.1.jar"]
