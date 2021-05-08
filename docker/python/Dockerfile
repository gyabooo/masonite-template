# pull official base image
FROM masonite:latest

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV TZ=UTC
ARG APP_USER
ARG APP_HOME
ENV APP_USER ${APP_USER}
ENV APP_HOME ${APP_HOME}

# set work directory
WORKDIR /usr/src/app

# install system dependencies
COPY ./docker/python/requirements.txt .
RUN apk update && apk --no-cache add postgresql-dev; \
  pip install --upgrade pip; \
  pip install -r requirements.txt; \
  chown -R ${APP_USER}:${APP_USER} ${APP_HOME}; \
  mkdir -p ${APP_HOME}; \
  addgroup -S ${APP_USER}; \
  adduser -S ${APP_USER} -G ${APP_USER}

# set work directory
WORKDIR ${APP_HOME}

# change to the app user
USER ${APP_USER}
