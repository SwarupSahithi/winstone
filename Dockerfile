FROM maven:3.9.4-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy everything including .git so buildnumber plugin can work
COPY . .

RUN mvn clean compile -DskipTests

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/classes ./classes

# CMD or ENTRYPOINT to run your app here
