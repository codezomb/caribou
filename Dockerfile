FROM public.ecr.aws/docker/library/ruby:3.2-alpine

WORKDIR /work

RUN <<EOF
apk update && apk add --no-cache bash gcompat postgresql-dev \
  postgresql-client tzdata git vim nodejs npm nginx

apk add --virtual build-dependencies build-base

adduser -D -s /bin/bash alpine
chown -R alpine:alpine /work
EOF

USER alpine

ARG BUNDLE_WITHOUT=development:test
ARG RAILS_ENV=production
ARG RAILS_MASTER_KEY

ENV RAILS_MASTER_KEY=${RAILS_MASTER_KEY}
ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}
ENV RAILS_ENV ${RAILS_ENV}
ENV NODE_ENV ${RAILS_ENV}

COPY --chown=alpine:alpine ./Gemfile* ./
RUN bundle install

COPY --chown=alpine:alpine . ./
RUN npm install
RUN rails assets:precompile
RUN rm -rf node_modules

ENTRYPOINT ["/work/bin/entrypoint"]
