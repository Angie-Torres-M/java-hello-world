# ---------- build stage ----------
FROM gradle:8.10-jdk21 AS build
WORKDIR /home/gradle/project
COPY . .
RUN gradle bootJar --no-daemon

# ---------- run stage ----------
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /home/gradle/project/build/libs/*.jar app.jar
EXPOSE 8080
ENV PORT=8080
ENTRYPOINT ["java","-jar","app.jar"]
