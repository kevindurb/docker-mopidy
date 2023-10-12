FROM docker.io/library/debian:11-slim

RUN apt update \
  && apt install -y \
  curl \
  python3-pip

RUN mkdir -p /etc/apt/keyrings \
  && curl -o /etc/apt/keyrings/mopidy-archive-keyring.gpg https://apt.mopidy.com/mopidy.gpg \
  && curl -o /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/bullseye.list

RUN apt update \
  && apt install -y \
  mopidy \
  libspotify12 \
  libspotify-dev

RUN rm -rf /var/lib/apt/lists/*

COPY ./requirements.txt ./
RUN pip install -r ./requirements.txt

ENTRYPOINT ["mopidy"]
