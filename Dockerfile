FROM ubuntu:22.04
ENV TZ=Europe/Stockholm \
    DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y \
    tzdata texlive-latex-extra texlive-fonts-extra texlive-fonts-recommended \
    texlive-science texlive-xetex texlive-bibtex-extra texlive-lang-european \ 
    make wget xz-utils && apt-get clean -y && \
    rm -rf /usr/share/doc/ && rm -rf /usr/share/man/ && \
    wget https://github.com/jgm/pandoc/releases/download/2.9.2.1/pandoc-2.9.2.1-1-amd64.deb && \
    apt install /pandoc-2.9.2.1-1-amd64.deb && rm pandoc-2.9.2.1-1-amd64.deb && \
    wget https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.6.3/pandoc-crossref-Linux-2.9.2.1.tar.xz && \
    unxz pandoc-crossref-Linux-2.9.2.1.tar.xz && tar xvf pandoc-crossref-Linux-2.9.2.1.tar && mv pandoc-crossref /usr/bin/pandoc-crossref && \
    rm pandoc-crossref-Linux-2.9.2.1.tar pandoc-crossref.1 && rm -rf /var/cache/apt/archives 
ARG UID=1000
ARG GID=1000
RUN groupadd -g "${GID}" pandoc && useradd --create-home -u "${UID}" -g "${GID}" pandoc
USER pandoc
WORKDIR /data
ENTRYPOINT /bin/bash

