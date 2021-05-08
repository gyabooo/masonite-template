# pull official base image
FROM python:3.9.0-alpine

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV TZ=UTC

# install system dependencies
COPY ./docker/masonite/requirements.txt .
RUN apk update && apk --no-cache add \
  libressl-dev libffi-dev gcc musl-dev python3-dev openssl-dev cargo; \
  pip install --upgrade pip; \
  pip install -r requirements.txt; \
  mkdir -p /backend/code

WORKDIR /backend/code
