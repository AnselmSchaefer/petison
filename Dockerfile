# Use a lightweight base image
FROM arm64v8/debian:bullseye-slim

# Optionally, set the working directory in the container
WORKDIR /app

# Copy the binary from the target directory into the Docker image
COPY target/petison /app/

# Make the binary executable
RUN chmod +x /app/petison

# Specify the command to run your binary when the container starts
CMD ["/app/petison"]