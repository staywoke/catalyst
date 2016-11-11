FROM quay.io/goodguide/ruby:ubuntu-mri-2.3.1-27

RUN apt-get update \
 && apt-get upgrade \
 && apt-get install \
      libcurl4-openssl-dev \
      libpq-dev \
      nodejs

RUN mkdir -p /gems

WORKDIR /app

ENV \
  BUNDLE_PATH=/gems \
  BUNDLE_RETRY=3 \
  BUNDLE_WITHOUT=local_tools

COPY Gemfile Gemfile.lock /app/
RUN BUNDLE_IGNORE_MESSAGES=true bundle install --jobs $(getconf _NPROCESSORS_ONLN)

ENV PATH="/app/bin:$PATH"

COPY ./app/ /app/app
COPY ./config/ /app/config
COPY ./lib/ /app/lib
COPY ./vendor/ /app/vendor
COPY Rakefile /app/
COPY ./bin/rake /app/bin/rake

# precompile assets -- the fakeing of env variables is a necessary evil until a better solution comes along
RUN DATABASE_URL=postgresql://fake \
    DEV_MODE=true \
    EXTERNAL_URL=http://fake \
    RAILS_ASSETS_PRECOMPILE=true \
    SECRET_KEY_BASE=fake \
    rake assets:precompile --trace \
 && rm -rf tmp/*

COPY . /app/

ENTRYPOINT ["/sbin/tini", "-vvg", "--", "/app/docker/entrypoint.sh"]
EXPOSE 3000

STOPSIGNAL SIGINT

CMD ["puma", "--config", "config/puma.rb"]
