# Use Maven to build the app
FROM maven:3.6.3-openjdk-8-slim AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Use JRE to run the app
FROM openjdk:8-jre-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]