#Script1
#Buscar a un usuario de semilla 
culo
apiKey<-"&api_key=82b23813669e5d6580f8a13e66e258e3"
enlaceUsuario<-"http://ws.audioscrobbler.com/2.0/?method=user.getfriends&limit=500&user="
listaUsuarios<-c('pabloskink')
maximo<-100
usuarioMaximo<-''
maxAmigos<-0

if (!require(XML)) install.packages("XML")
require(XML)

count<-1

while(length(listaUsuarios) < maximo){
  usuario<-listaUsuarios[count]
  print(paste("Analizando al usuario",usuario))
  enlace<-paste(enlaceUsuario,usuario,apiKey,sep="")
  datos<-xmlParse(enlace)
  xml_data <- xmlToList(datos)
  print(xml_data[["friends"]][[".attrs"]])
  usuarios <- as.list(xml_data[["friends"]])
  amigos<-length(usuarios) - 1
  if(amigos > 0){
    if(amigos > maxAmigos){
      maxAmigos<-amigos
      usuarioMaximo<-usuario
    }
    
    for(i in 1:amigos){
      if(!is.element(usuarios[[i]][[1]], listaUsuarios)){
        listaUsuarios<-c(listaUsuarios,usuarios[[i]][[1]])
      }
    }
  }
  
  count<-count+1
}
print(listaUsuarios)
print(usuarioMaximo)
print(maxAmigos)