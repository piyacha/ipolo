FROM ruby:alpine

## File imagemagick  is need for paperclip
RUN apk --update add --virtual build-dependencies build-base git ruby-dev openssl-dev libxml2-dev libxslt-dev \
    libc-dev linux-headers nodejs tzdata file imagemagick && gem install bundler
RUN gem update bundler
RUN mkdir /app
#RUN gem source --add http://ideractive.com:9292

#FROM ideractive/slou:latest
VOLUME ["/app"]
WORKDIR /app

# RUN chmod 777 /app
RUN apk --update add --virtual libsqlite3-dev sqlite-dev sqlite-libs

RUN apk add --no-cache \
            xvfb \
            # Additionnal dependencies for better rendering
            ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family\
            fontconfig \
            dbus \

    && \
    # Install wkhtmltopdf from `testing` repository
    apk add qt5-qtbase-dev \
            wkhtmltopdf \
            --no-cache \
            --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
            --allow-untrusted \
    && \
    # Wrapper for xvfb
    mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf-origin && \
    echo $'#!/usr/bin/env sh\n\
Xvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset & \n\
DISPLAY=:0.0 wkhtmltopdf-origin $@ \n\
killall Xvfb\
' > /usr/bin/wkhtmltopdf && \
    chmod +x /usr/bin/wkhtmltopdf

# RUN gem install idr_active_extension -v "~> 0.1"
# RUN gem install idr_media_manager -v "~> 0.1"

COPY idr_active_extension-0.1.4.gem /app/idr_active_extension-0.1.4.gem
RUN gem install --local idr_active_extension-0.1.4.gem

COPY idr_media_manager-0.1.5.gem /app/idr_media_manager-0.1.5.gem
RUN gem install --local idr_media_manager-0.1.5.gem

COPY idr_reports-1.1.gem /app/idr_reports-1.1.gem
RUN gem install --local idr_reports-1.1.gem

RUN gem install sqlite3
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install

# Set Rails to run in production
ENV SECRET_KEY_BASE aa89a3fe86780a087166420560f0951ef777ed2450922b05139a70b04143e59d4ab5623c16b1859464e76c0d736093767ba7433484d2759452851aeaa154dfbe
ENV RAILS_ENV production
ENV RACK_ENV production

# Precompile Rails assets
# RUN bundle exec rake assets:precompile

# Start puma
# CMD bundle exec puma -C config/puma.rb