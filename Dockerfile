FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y nodejs --no-install-recommends yarn chromium-driver && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y postgresql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN mkdir /favo-docker
WORKDIR /favo-docker
COPY Gemfile /favo-docker/Gemfile
COPY Gemfile /favo-docker/Gemfile.lock
RUN gem install bundler
RUN bundle install

COPY . /favo-docker
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]