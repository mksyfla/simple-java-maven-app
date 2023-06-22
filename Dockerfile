FROM openjdk:11-jre-slim
WORKDIR /app
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]