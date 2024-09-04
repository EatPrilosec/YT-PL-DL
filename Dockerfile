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

RUN mkdir -p /app
#RUN chown 1000:1000 -R /opt
WORKDIR /app

ENV USER_ID 9001
ENV GROUP_ID 255361
RUN addgroup --gid $GROUP_ID userg
RUN useradd --shell /bin/bash -u $USER_ID -g $GROUP_ID -o -c "" -m user
ENV HOME /home/user
RUN chown -R user:userg $HOME

RUN mkdir -p /app
RUN chown $USER_ID:$GROUP_ID -R /app

FROM base AS add
ADD  --chmod=777 files* /app/
RUN chmod -R 777 /app

ENV CronSchedule="0,20,40 5-22 * * *"
ENV Playlist="https://www.youtube.com/playlist?list=PLYJsyEKS11ydV1tC2wJtc3CkwczCyYNyZ"
ENV Playlist_name="music"
ENV Playlists_Path="/Storage/Media/Unorganized/ytdlp/playlists"
ENV Playlist_TempPath="/Storage/.cache"
ENV Playlist_Archive="/Storage/Media/Unorganized/ytdlp/mymusic-archive"
ENV PUID="1000"
ENV PGID="1000"

ENV CronCommand /app/epg-start.sh
SHELL ["/bin/bash", "-c"]
CMD usermod -u $PUID user ; \
    groupmod -g $PGID userg ; \
    usermod -a -G sudo user ; \
    chown -R user:userg $HOME ; \
    chown -R user:userg /app ; \
    env >/app/env ; \
    ls -l /app ; \
    sudo -E --group=userg --user=user $CronCommand >/app/cron.log 2>/app/cron.log & \
    echo "$CronSchedule sudo -E --group=userg --user=user $CronCommand >/app/cron.log 2>/app/cron.log" >/home/user/cronfile ; \
    crontab /home/user/cronfile ; \
    cron & \
    tail -F /app/cron.log

