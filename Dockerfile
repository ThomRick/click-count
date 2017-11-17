FROM maven
WORKDIR /usr/src/app
COPY . .
RUN mvn install

FROM tomcat
COPY --from=0 /usr/src/app/target/clickCount.war /usr/local/tomcat/webapps/clickCount.war