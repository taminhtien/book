ARG RUBY_VERSION=3.2.0

FROM ruby:$RUBY_VERSION-slim

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libxml2-dev libxslt1-dev libvips gnupg2 curl git

# Ensure node.js 19 is available for apt-get
ARG NODE_MAJOR=19
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -

# Install node and yarn
RUN apt-get update -qq && apt-get install -y nodejs && npm install -g yarn

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler
RUN bundle update --bundler
RUN bundle lock --add-platform x86_64-linux
RUN bundle install

COPY . ./

RUN bundle exec rails assets:precompile

# Set Rails to run in production
ENV RAILS_ENV production
ENV RACK_ENV production

# Copy the main application.
COPY . ./
