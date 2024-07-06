#!/bin/bash

echo "Playlist="$Playlist"" >/opt/env
echo "Playlist_name="$Playlist_name"" >>/opt/env
echo "Playlists_Path="$Playlists_Path"" >>/opt/env
echo "Playlist_TempPath="$Playlist_TempPath"" >>/opt/env
echo "Playlist_Archive="$Playlist_Archive"" >>/opt/env

addgroup --quiet --gid $PGID ytpldl

adduser --quiet --uid $PUID --gid $PGID --no-create-home ytpldl



echo "$CronSchedule sudo --group=ytpldl --user=ytpldl /opt/get-YTMusicPlaylist.sh >/opt/ytpldl.log 2>/opt/ytpldl.log" >/opt/cron

crontab /opt/cron
touch /opt/ytpldl.log
cron && tail -f /opt/ytpldl.log



