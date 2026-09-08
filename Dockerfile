FROM ruby:3.1.4

RUN apt-get update -qq && apt-get install -y default-mysql-client

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .
