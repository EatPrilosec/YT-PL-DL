#!/bin/bash


echo "Playlist="$Playlist"" >/opt/env
echo "Playlist_name="$Playlist_name"" >>/opt/env
echo "Playlists_Path="$Playlists_Path"" >>/opt/env
echo "Playlist_TempPath="$Playlist_TempPath"" >>/opt/env
echo "Playlist_Archive="$Playlist_Archive"" >>/opt/env

echo "$CronSchedule /opt/get-YTMusicPlaylist.sh" >/opt/cron
crontab /opt/cron
touch /opt/cron.log
cron && tail -f /opt/cron.log



