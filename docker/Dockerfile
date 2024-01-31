FROM alpine:latest 

LABEL maintainer="yingchao <yingchao.tw@google.com>"

# Install dependencies that rarely change
RUN apk update && apk add --no-cache \
    texlive-full biber icu-data-full ghostscript make cmake shadow \
    sudo musl

# ARGs to configure user
ARG USER
ARG USERID
ARG GROUPID
ARG PROJECT
ARG PROJECTDIR=/home/$USER

# Update UID login.defs accordingly
RUN echo -e "UID_MIN 500\nUID_MAX 60000" > /etc/login.defs

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

# Set work directory
WORKDIR $PROJECTDIR/$PROJECT

# Set user for the container
USER $USER

# Final command
CMD ["bash", "-l"]
