#!/bin/sh
echo ARBITER_BASE_SOCKET_URL=$ARBITER_BASE_SOCKET_URL > .env && \
echo ARBITER_BASE_API_URL=$ARBITER_BASE_API_URL >> .env  && \
if cd flutter; then git pull && cd .. ; else git clone https://github.com/flutter/flutter.git -b stable; fi && ls && cd flutter && git checkout 3.19.1 && cd .. && flutter/bin/flutter doctor && flutter/bin/flutter clean && flutter/bin/flutter pub get