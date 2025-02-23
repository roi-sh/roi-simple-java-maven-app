FROM maven:3.9.2-eclipse-temurin-17 AS build
WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src/main/java/com/mycompany/app .

RUN ls

# Build the application (creates the JAR file inside /app/target)
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Set the entrypoint to run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]

