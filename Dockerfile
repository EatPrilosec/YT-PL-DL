ARG TAG=bookworm
ARG DEBIAN_FRONTEND=noninteractive
FROM debian:${TAG} as base

RUN echo 'debconf debconf/frontend select teletype' | debconf-set-selections

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" -y install cron sudo python3 


RUN apt-get clean
RUN rm -rf                        \
    /var/lib/apt/lists/*          \
    /var/log/alternatives.log     \
    /var/log/apt/history.log      \
    /var/log/apt/term.log         \
    /var/log/dpkg.log

RUN rm -f           \
    /etc/machine-id \
    /var/lib/dbus/machine-id



RUN mkdir -p /opt
#RUN chown 1000:1000 -R /opt
WORKDIR /opt

FROM base AS add
ADD  --chmod=777 files* /opt/
RUN chmod -R 777 /opt

ENV CronSchedule="0,20,40 5-22 * * *"
ENV Playlist="https://www.youtube.com/playlist?list=PLYJsyEKS11ydV1tC2wJtc3CkwczCyYNyZ"
ENV Playlist_name="music"
ENV Playlists_Path="/Storage/Media/Unorganized/ytdlp/playlists"
ENV Playlist_TempPath="/Storage/.cache"
ENV Playlist_Archive="/Storage/Media/Unorganized/ytdlp/mymusic-archive"
ENV PUID="1000"
ENV PGID="1000"
#USER 1000:1000

CMD ["/opt/cron_start.sh"]
