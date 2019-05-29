###Script de tratamiento y minería de datos
###Pablo Miranda Torres

###Librería usada para el filtrado de datos
require(dplyr)

#Leemos los datos del csv de las canciones
fichero<-"listaCanciones.csv"
if(!file.exists(fichero)){
  print("ERROR: No se ha encontrado el fichero de los datos")
}
datos<-read.csv(fichero, header = TRUE, na.strings=".", stringsAsFactors=FALSE, quote="", fill=FALSE) 


#Datos por décadas
lista1960<- datos%>% filter(year %in% (1960:1969))
lista1970<- datos%>% filter(year %in% (1970:1979))
lista1980<- datos%>% filter(year %in% (1980:1989))
lista1990<- datos%>% filter(year %in% (1990:1999))
lista2000<- datos%>% filter(year %in% (2000:2009))
lista2010<- datos%>% filter(year %in% (2010:2016))


#Evolución de la bailabilidad por décadas
means<-c(mean(lista1960$danceability),mean(lista1970$danceability),mean(lista1980$danceability),mean(lista1990$danceability),mean(lista2000$danceability),mean(lista2010$danceability))
barplot(means, names.arg = c("60","70", "80","90","00","10"), col = rainbow(6), ylab = "Danceability", xlab = "Década",ylim = c(0,1))

#Evolución de la alegría de la música por décadas
means<-c(mean(lista1960$valence),mean(lista1970$valence),mean(lista1980$valence),mean(lista1990$valence),mean(lista2000$valence),mean(lista2010$valence))
barplot(means, names.arg = c("60","70", "80","90","00","10"), col = rainbow(6), ylab = "Valence", xlab = "Década",ylim = c(0,1))

#Evolución de la acústica de la música por décadas
means<-c(mean(lista1960$acousticness),mean(lista1970$acousticness),mean(lista1980$acousticness),mean(lista1990$acousticness),mean(lista2000$acousticness),mean(lista2010$acousticness))
barplot(means, names.arg = c("60","70", "80","90","00","10"), col = rainbow(6), ylab = "Acousticness", xlab = "Década", ylim = c(0,1))

#Evolución del discurso de la música por décadas
means<-c(mean(lista1960$speechiness),mean(lista1970$speechiness),mean(lista1980$speechiness),mean(lista1990$speechiness),mean(lista2000$speechiness),mean(lista2010$speechiness))
barplot(means, names.arg = c("60","70", "80","90","00","10"), col = rainbow(6), ylab = "Speechiness", xlab = "Década",ylim = c(0,1))

#Evolución de la energía de la música por décadas
means<-c(mean(lista1960$energy),mean(lista1970$energy),mean(lista1980$energy),mean(lista1990$energy),mean(lista2000$energy),mean(lista2010$energy))
barplot(means, names.arg = c("60","70", "80","90","00","10"), col = rainbow(6), ylab = "Energy", xlab = "Década",ylim = c(0,1))



#Fase del clustering
#Copiamos los datos a otro objeto para poder eliminar las variables que no nos interesan
datos1<-datos
datos1$tempo<-NULL
datos1$artist<-NULL
datos1$song<-NULL
datos1$spotifyid<-NULL
datos1$year<-NULL
datos1$liveness<-NULL

#Creamos la semilla para garantizar la aleatoriedad
set.seed(1000)
#Realizamos el clustering
clusters <- kmeans(datos1, 3)
print(clusters)
#Devolvemos la variable año al objeto, para poder mostrar la evolución con el paso de los años de manera visual
datos1$year<-datos$year
#Mostramos los gráficos con los clusters, el segundo con respecto a los años
plot(datos1[c("energy","valence")], pch = 20 ,col = clusters$cluster)
plot(datos1[c("year","valence")], pch = 20, col = clusters$cluster)

