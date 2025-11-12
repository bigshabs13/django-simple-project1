# Use an official Python image
FROM python:3.11-slim

# Prevents Python from writing .pyc files and buffers
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Install build dependencies (needed for mysqlclient / mariadb)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential libmariadb-dev pkg-config \
 && rm -rf /var/lib/apt/lists/*

# Copy dependency list first (for caching)
COPY requirements.txt .

# Install Python dependencies
RUN python -m pip install --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

# Copy the entire Django project into the container
COPY . .

# Change directory to where manage.py actually lives
WORKDIR /app/website

# Expose Django’s default port
EXPOSE 8000

# Run Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
