FROM ruby:3.0.2
RUN apt-get update -q
RUN apt-get install -y  apt-utils \
                        build-essential \
                        postgresql-client

WORKDIR /userara-api

COPY Gemfile /userara-api/Gemfile
COPY Gemfile.lock /userara-api/Gemfile.lock

RUN bundle install

COPY . /userara-api

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]