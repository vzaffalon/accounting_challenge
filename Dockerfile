FROM ruby:2.5-alpine

RUN apk add --update --no-cache \   
    git \
    build-base \
    nodejs \
    mysql-dev \
    bash \
    tzdata

ENV RAILS_ROOT /app
RUN mkdir -p $RAILS_ROOT
# Set working directory
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock ./

RUN bundle install --binstubs

COPY . .

EXPOSE 3000

ENTRYPOINT ["sh", "entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0"]