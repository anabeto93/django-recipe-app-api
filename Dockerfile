# FROM python:3.7-alpine
FROM python:3.7-slim
MAINTAINER Richard Anabeto Opoku

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install Dependencies
COPY ./requirements.txt /requirements.txt
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y gcc && \
    apt-get clean

# RUN apk update && \
#     apk add --update --no-cache --virtual .tmp-build-deps \
#     gcc libc-dev linux-headers \
#     && apk add postgresql-dev \
#     && apk add --update --no-cache postgresql-client

RUN pip install --upgrade pip
RUN pip install psycopg2-binary
RUN pip install -r /requirements.txt
# RUN apk del .tmp-build-deps

# App Directory
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Create Default User
# RUN adduser -D user 
RUN addgroup --system user && adduser --system --no-create-home --group user
RUN chown -R user:user /app && chmod -R 755 /app

USER user