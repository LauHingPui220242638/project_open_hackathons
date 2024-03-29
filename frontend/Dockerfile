
FROM debian:latest AS build-env

RUN apt-get update && \
    apt-get install -y \
        xz-utils \
        git \
        openssh-client \
        curl && \
    rm -rf /var/cache/apt

ARG FLUTTER_SOURCE=flutter_linux_3.13.9-stable.tar.xz
ARG FLUTTER_SDK=/usr/local/
ARG APP=/app
ENV PATH=$FLUTTER_SDK/flutter/bin/:$FLUTTER_SDK/flutter/bin/cache/dart-sdk/bin/:${PATH}

RUN git config --global --add safe.directory /usr/local/flutter

    

# RUN git clone https://github.com/flutter/flutter.git $FLUTTER_SDK
# RUN cd $FLUTTER_SDK && git checkout efbf63d9c66b9f6ec30e9ad4611189aa80003d31
RUN cd ${FLUTTER_SDK}
RUN curl -L https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/${FLUTTER_SOURCE} | tar -C $FLUTTER_SDK -xJ



# RUN flutter doctor -v

WORKDIR $APP
COPY . $APP
RUN cd $APP
RUN flutter clean
RUN flutter pub get
RUN flutter build web


FROM nginx:1.21.1-alpine

ARG APP=/app

COPY --from=build-env ${APP}/build/web /usr/share/nginx/html
COPY --from=build-env ${APP}/nginx.conf /etc/nginx/


EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]