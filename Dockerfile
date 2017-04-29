FROM joserocha/weby
ADD . /weby
WORKDIR /weby
RUN bundle install
RUN bundle exec rake assets:precompile --trace
CMD export SECRET_KEY_BASE=`bundle exec rake secret`
RUN cp config/secrets.yml.example config/secrets.yml && cp config/database.yml.example config/database.yml

# FROM ruby:2.1.7
# MAINTAINER Webmaster Team "web@cercomp.ufg.br"
# RUN apt-get update
# RUN apt-get install -y git imagemagick libpq-dev libncurses5-dev libffi-dev curl build-essential libssl-dev libreadline6-dev zlib1g-dev zlib1g libsqlite3-dev libmagickwand-dev libqtwebkit-dev libqt4-dev libreadline-dev libxslt-dev
# ADD Gemfile Gemfile.lock Rakefile config.ru /weby/
# WORKDIR /weby
# RUN gem install bundler
# RUN bundle install

# FROM ruby:2.1.7
# MAINTAINER Webmaster Team "web@cercomp.ufg.br"
# RUN apt-get update
# RUN apt-get install -y git imagemagick libpq-dev libncurses5-dev libffi-dev curl build-essential libssl-dev libreadline6-dev zlib1g-dev zlib1g libsqlite3-dev libmagickwand-dev libqtwebkit-dev libqt4-dev libreadline-dev libxslt-dev
# RUN git clone https://github.com/cercomp/weby
# WORKDIR /weby
# RUN gem install bundler
# RUN bundle install
# RUN cp config/secrets.yml.example config/secrets.yml
# RUN cp config/database.yml.example config/database.yml
# RUN bundle exec rake assets:precompile --trace
# CMD export SECRET_KEY_BASE=`bundle exec rake secret`
# CMD rails s -b 0.0.0.0 -p 3000