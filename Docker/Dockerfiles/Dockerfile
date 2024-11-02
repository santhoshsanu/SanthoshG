FROM amazoncorretto:17-alpine3.17-jdk
LABEL author="santhosh" 
RUN mkdir -p /spc/jarfile/
COPY spring-petclinic-3.3.0-SNAPSHOT.jar /spc/jarfile/
WORKDIR /spc/jarfile/
CMD ["java", "-jar", spring-petclinic-3.3.0-SNAPSHOT.jar]