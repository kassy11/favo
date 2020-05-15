FROM ruby:2.7.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn chromium-driver
RUN mkdir /favo
WORKDIR /favo
COPY Gemfile /favo/Gemfile
COPY Gemfile.lock /favo/Gemfile.lock
RUN gem install bundler # 追記
RUN bundle install
COPY . /myapp
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]