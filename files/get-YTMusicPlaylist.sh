#!/bin/bash
/opt/yt-dlp -U

/opt/yt-dlp --embed-metadata --windows-filenames \
	--parse-metadata "title:%(artist)s - %(track)s" \
	--embed-metadata \
	-o 'music/%(artist|Unknown Artist)s - %(track|Unknown Song Name)s __ %(fulltitle)s.%(ext)s' -f m4a \
	-P "/Storage/Media/Unorganized/ytdlp/playlists" \
	-P temp:'/Storage/.cache' \
	--buffer-size 4k -N 8 --resize-buffer \
	--download-archive /Storage/Media/Unorganized/ytdlp/mymusic-archive \
	https://www.youtube.com/playlist?list=PLYJsyEKS11ydV1tC2wJtc3CkwczCyYNyZ | grep -v 'has already been recorded in the archive'

/opt/yt-dlp --embed-metadata --windows-filenames \
	--parse-metadata "title:%(artist)s - %(track)s" \
        --embed-metadata \
	-o 'booboo1/%(artist|Unknown Artist)s - %(track|Unknown Song Name)s __ %(fulltitle)s.%(ext)s' -f m4a \
	-P "/Storage/Media/Unorganized/ytdlp/playlists" \
	-P temp:'/Storage/.cache' \
	--buffer-size 4k -N 8 --resize-buffer \
	--download-archive /Storage/Media/Unorganized/ytdlp/booboo1-archive \
	https://www.youtube.com/playlist?list=PLdnOKzWLkLoJDaiZPgVMTE9DW7WKWoSLk | grep -v 'has already been recorded in the archive'

#--sponsorblock-remove music_offtopic \
exit 0
