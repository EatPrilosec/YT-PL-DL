#!/bin/bash
id
ls -l /Storage/Media/Unorganized/ytdlp/playlists
ls -l /Storage/.cache
ls -l /Storage
ls -l /Storage/Media/Unorganized/ytdlp/mymusic-archive

. /app/env
echo Playlist: $Playlist 						#https://www.youtube.com/playlist?list=PLYJsyEKS11ydV1tC2wJtc3CkwczCyYNyZ
echo Playlist_name: $Playlist_name 				#music
echo Playlists_Path: $Playlists_Path 			#/Storage/Media/Unorganized/ytdlp/playlists
echo Playlist_TempPath: $Playlist_TempPath 		#/Storage/.cache
echo Playlist_Archive: $Playlist_Archive 		#/Storage/Media/Unorganized/ytdlp/mymusic-archive

/app/yt-dlp -U
/app/yt-dlp --version
echo /app/yt-dlp --embed-metadata --windows-filenames \
	--parse-metadata "title:%(artist)s - %(track)s" \
	--embed-metadata \
	-o "$Playlist_name/%(artist|Unknown Artist)s - %(track|Unknown Song Name)s __ %(fulltitle)s.%(ext)s" -f m4a \
	-P "$Playlists_Path" \
	-P "temp:$Playlist_TempPath" \
	--buffer-size 4k -N 8 --resize-buffer \
	--download-archive $Playlist_Archive \
	$Playlist 
/app/yt-dlp --embed-metadata --windows-filenames \
	--parse-metadata "title:%(artist)s - %(track)s" \
	--embed-metadata \
	-o "$Playlist_name/%(artist|Unknown Artist)s - %(track|Unknown Song Name)s __ %(fulltitle)s.%(ext)s" -f m4a \
	-P "$Playlists_Path" \
	-P "temp:$Playlist_TempPath" \
	--buffer-size 4k -N 8 --resize-buffer \
	--download-archive $Playlist_Archive \
	$Playlist | grep -v 'has already been recorded in the archive'

#--sponsorblock-remove music_offtopic \
exit 0


