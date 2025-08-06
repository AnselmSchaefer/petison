# Use an official OpenJDK runtime as a parent image
FROM paketobuildpacks/graalvm:9.1.5

# Set the working directory in the container
WORKDIR /app

# Copy the jar file into the container
COPY target/petison-0.0.1-SNAPSHOT.jar /app/app.jar

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]