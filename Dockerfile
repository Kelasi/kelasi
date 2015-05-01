FROM kelasi/docker-rails-base:latest


COPY . /usr/src/app
WORKDIR /usr/src/app

ENV PORT 3000
EXPOSE $PORT

# RUN rake db:setup

CMD bundle exec passenger start -p $PORT --max-pool-size 3

