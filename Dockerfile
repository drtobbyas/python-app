# Stage 1: Builder
# Use an official Python runtime as a parent image for the builder stage
FROM python:3.9-slim AS builder

# Set the working directory
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Final image
# Use a slim Python runtime for the final image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Create a non-root user and group to run the application
# Using a non-root user is a security best practice
RUN addgroup --system app && adduser --system --group app

# Copy the installed Python packages and executables from the builder stage
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copy the application code into the final image
COPY src ./src

# Change the ownership of the application directory to the non-root user
RUN chown -R app:app /app

# Switch to the non-root user
USER app

# Expose the port the application runs on
EXPOSE 8000

# Define the command to run the application
CMD ["uvicorn", "src.app:app", "--host", "0.0.0.0", "--port", "8000"]
