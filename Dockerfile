# Use the Python 3.9.18 slim image as the base image
FROM python:3.9.18-slim

# Set the working directory inside the container
WORKDIR /app

# Install curl and other necessary packages
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user and group
RUN useradd -ms /bin/sh myuser

# Copy the requirements.txt file into the container
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Change ownership of the application directory to the non-root user
RUN chown -R myuser:myuser /app

# Switch to the non-root user
USER myuser

# Expose the PORT environment variable
EXPOSE $PORT

# Command to run the application using gunicorn, with dynamic port
CMD ["gunicorn", "-b", "0.0.0.0:$PORT", "--access-logfile", "-", "--error-logfile", "-", "index:app"]
