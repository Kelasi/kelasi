FROM ruby:2.1.5


# Intall gems through bundler
RUN bundle config --global frozen 1 \
  && mkdir -p /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

WORKDIR /usr/src/app
RUN bundle install --binstubs


# Setup http port
ENV PORT 3000
EXPOSE $PORT


COPY . /usr/src/app

CMD bundle exec passenger start -p $PORT --max-pool-size 3

