FROM ruby:3.1.2-slim-buster

MAINTAINER taminhtien1993@gmail.com

RUN apt-get update -qq --fix-missing \
  && apt-get install -y build-essential libpq-dev libxml2-dev libxslt1-dev cron git curl \
  && rm -rf /var/lib/apt/lists/* /tmp/*

RUN curl --compressed -o- -L https://yarnpkg.com/install.sh | bash

RUN mkdir -p /app
RUN mkdir -p /app/tmp/pids
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.3.1 && bundle install --jobs 20 --retry 5 --without test
RUN bundle exec rails assets:precompile

# Set Rails to run in production
ENV RAILS_ENV production
ENV RACK_ENV production

# Copy the main application.
COPY . ./
