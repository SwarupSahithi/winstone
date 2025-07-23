# Stage 1: Build
FROM maven:3.9.4-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /app

# Copy pom.xml and download dependencies (cache layer)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build project (skip tests for speed)
RUN mvn clean compile -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy compiled classes from build stage
COPY --from=builder /app/target/classes ./classes

# (Optional) Set entrypoint or CMD if you have a main class or jar
# CMD ["java", "-cp", "classes", "your.main.Class"]

# For example, if you have a fat jar, adjust accordingly
# COPY --from=builder /app/target/your-app.jar ./your-app.jar
# CMD ["java", "-jar", "your-app.jar"]
