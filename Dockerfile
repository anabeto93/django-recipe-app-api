FROM python:3.7-alpine
MAINTAINER Richard Anabeto Opoku

ENV PYTHONUNBUFFERED 1

# Install Dependencies
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# App Directory
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Create Default User
RUN adduser -D user 
USER user