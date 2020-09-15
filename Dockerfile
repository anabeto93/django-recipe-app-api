FROM python:3.7-alpine
MAINTAINER Richard Anabeto Opoku

ENV PYTHONUNBUFFERED 1

# Install Dependencies
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# App Directory
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Create Default User
RUN adduser -D user 
USER user