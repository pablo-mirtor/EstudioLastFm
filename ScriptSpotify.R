
###Librería para poder trabajar con la API de Spotify
if (!require(spotifyr)) install.packages("spotifyr")
require(spotifyr)
###Librería que devuelve las listas con el top 100 éxitos de cada año de Billboard
if (!require(billboard)) install.packages("billboard")
require(billboard)

###Credenciales de la API de Spotify y acceso (es posible que estos valores caduquen, más info en la memoria)
Sys.setenv(SPOTIFY_CLIENT_ID = '3a8d8497982e4e79993b152a70dd15cc')
Sys.setenv(SPOTIFY_CLIENT_SECRET = 'f69409df2b6744229536c5e04d91a74f')
access_token <- get_spotify_access_token()

###Almacenamos en un fichero los enlaces a las listas de Spotify con el top 100 de cada año en Spotify
###(este archivo como tal no es necesario, pero se almacena a modo de backup por si fallase la librería billboard)
nombreFicheroPlaylists<-"listaPlaylists.csv"
write.csv(spotify_playlists[4], file = fileName)

###Creamos el fichero del dataset que vamos a tratar
nombreFicheroCanciones<-"listaCanciones.csv"
sink(nombreFicheroCanciones)
cat(paste("year","song","artist","spotifyid","danceability","energy","speechiness","acousticness","instrumentalness","liveness","valence","tempo \n",sep=","))

###Escribimos los datos de cada canción en el fichero
year<-1960
for(i in 1:length(spotify_playlists$spotify_playlist)){
  playlist<-get_playlist_tracks(spotify_playlists$spotify_playlist[i])
  for(j in 1:length(playlist$track.uri)){
    playlist$track.id
    song <-get_track_audio_features(playlist$track.id[j])
    if(!is.null(song$danceability)){ ###Limpieza de datos, limpiamos canciones que devuelvan valores nulos (ligeras excepciones)
      songName<-gsub(',','',playlist$track.name[j]) ###Limpiamos las comas de los títulos para evitar confundir al fichero csv
      artistName<-gsub(',','',playlist$track.artists[[j]]$name[1])
      cat(paste(year,songName,artistName,playlist$track.id[[j]],song$danceability,song$energy,song$speechiness,song$acousticness,song$instrumentalness,song$liveness,song$valence,song$tempo,sep=","))
      cat('\n')
    }
  }
  year<-year+1
}

sink()
