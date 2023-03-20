ARG RUBY_VERSION=3.2.0

FROM ruby:$RUBY_VERSION-slim

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libxml2-dev libxslt1-dev libvips gnupg2 curl git

# Ensure node.js 19 is available for apt-get
ARG NODE_MAJOR=19
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -

# Install node and yarn
RUN apt-get update -qq && apt-get install -y nodejs && npm install -g yarn

# Set an environment variable where the Rails app is installed to inside of Docker image:
ENV RAILS_ROOT /var/www/book_purchase
RUN mkdir -p $RAILS_ROOT

# Set working directory, where the commands will be ran:
WORKDIR $RAILS_ROOT

# Set Rails to run in production
ENV RAILS_ENV production
ENV RACK_ENV production

COPY Gemfile Gemfile.lock ./

RUN gem install bundler
RUN bundle update --bundler
RUN bundle lock --add-platform x86_64-linux
RUN bundle install

COPY . ./

RUN bundle exec rails assets:precompile


EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
