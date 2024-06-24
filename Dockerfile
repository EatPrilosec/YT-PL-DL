ARG TAG=bookworm
ARG DEBIAN_FRONTEND=noninteractive
FROM debian:${TAG} as base

RUN echo 'debconf debconf/frontend select teletype' | debconf-set-selections

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" -y install cron anacron python3 


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
RUN chown 1000:1000 -R /opt
WORKDIR /opt

#ADD --chown=1000:1000 --chmod=777 ["files/yt-dlp" "/opt"]
#ADD --chown=1000:1000 --chmod=777 ["files/scripts/get-YTMusicPlaylist.sh" "/opt"]
FROM base AS add
ADD --chown=1000:1000 --chmod=777 files* /opt/


ENV Playlist="https://www.youtube.com/playlist?list=PLYJsyEKS11ydV1tC2wJtc3CkwczCyYNyZ"
ENV Playlist_name="music"
ENV Playlists_Path="/Storage/Media/Unorganized/ytdlp/playlists"
ENV Playlist_TempPath="/Storage/.cache"
ENV Playlist_Archive="/Storage/Media/Unorganized/ytdlp/mymusic-archive"

USER 1000:1000
CMD ["/opt/get-YTMusicPlaylist.sh"]