FROM alpine

WORKDIR /work

RUN apk add ansible openssh

RUN ansible-galaxy collection install ericsysmin.docker
RUN ansible-galaxy install jellycsc.v2ray
RUN ansible-galaxy install christiangda.amazon_cloudwatch_agent
RUN ansible-galaxy install christiangda.amazon_ssm_agent
