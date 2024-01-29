# # syntax=docker/dockerfile:1.3-labs

FROM alpine:latest AS base

LABEL maintainer="yingchao <yingchao.tw@google.com>"

# clean apt buffer and rebuild.
RUN apk update && apk add --no-cache \
    texlive-full biber icu-data-full make cmake shadow
    # bash-completion bash \ 
    # sudo musl

# user configuration - rootless setup
ARG USER
ARG USERID
ARG GROUPID
ARG PROJECT
ARG PROJECTDIR=/home/$USER

# Update UID login.defs accordingly
RUN echo -e "UID_MIN 500\nUID_MAX 60000" > /etc/login.defs;

# Create user and group if they do not exist
RUN set -x \
    && if ! (getent group $GROUPID > /dev/null); then \
           groupadd -g $GROUPID $USER; \
       fi \
    && if ! (id -u $USER > /dev/null 2>&1); then \
           useradd -u $USERID -g $GROUPID -m -s /bin/bash $USER; \
       fi \
    && echo "$USER:123totaiwan" | chpasswd

RUN echo "%wheel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN addgroup $USER wheel

# COPY --from=latex /usr/share/texmf/         /usr/share/texmf/
# COPY --from=latex /usr/local/texlive/       /usr/local/texlive/


# work directory
WORKDIR $PROJECTDIR/$PROJECT

# login
USER $USER

CMD ["bash", "-l"]
