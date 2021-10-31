FROM ruby:3.0.2

WORKDIR /data

RUN bundle config --delete frozen \
 && apt-get update -qq && apt-get install -y build-essential \
 && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
 && apt-get install -y nodejs \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get install -y iputils-ping net-tools \
 && apt-get update && apt-get install yarn

RUN bundle config set path vendor/bundle

COPY ./run.sh /run.sh

CMD sh /run.sh
