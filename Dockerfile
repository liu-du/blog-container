FROM rocker/rstudio:3.6.1

# Add shiny server
RUN export ADD=shiny && bash /etc/cont-init.d/add

# Useful packages

# tidyverse
RUN install2.r -e -n -1 tidyverse

# blogdown
RUN install2.r -e -n -1 blogdown miniUI

# hugo
ENV HUGO_VERSION=0.58.3
ARG HUGO_TAR=hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz
RUN wget -P /tmp/hugo https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_TAR} && \
    tar -xzf /tmp/hugo/${HUGO_TAR} -C /tmp/hugo && mv /tmp/hugo/hugo usr/local/bin && \
    rm -rf /tmp/hugo && hugo version

# haskell 8.6.5
RUN apt-get update && \
    apt-get install -y --no-install-recommends gnupg dirmngr && \ 
    echo 'deb http://downloads.haskell.org/debian stretch main' > /etc/apt/sources.list.d/ghc.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA3CBA3FFE22B574 && \
    apt-get update && \
    apt-get install -y --no-install-recommends ghc-8.6.5
RUN ln /opt/ghc/bin/ghc /usr/local/bin/ghc