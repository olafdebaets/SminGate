FROM alpine:latest

LABEL application="smingate"

#install additional packages
RUN apk add bash
RUN apk add curl && apk add jq

COPY ./getParameters.sh /opt/getParameters.sh

WORKDIR /opt/

RUN chmod 744 ./getParameters.sh

CMD ./getParameters.sh
