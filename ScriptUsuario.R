#Script1
#Buscar a un usuario de semilla 

apiKey<-"&api_key=82b23813669e5d6580f8a13e66e258e3"
enlaceUsuario<-"http://ws.audioscrobbler.com/2.0/?method=user.getfriends&user="
listaUsuarios<-c('pabloskink')
maximo<-1000
usuarioMaximo<-''
maxAmigos<-0

if (!require(XML)) install.packages("XML")
require(XML)

count<-0

while(length(listaUsuarios) < maximo){
  usuario<-listaUsuarios[count]
  enlace<-paste(enlaceUsuario,usuario,apiKey,sep="")
  datos<-xmlParse(enlace)
  xml_data <- xmlToList(datos)
  usuarios <- as.list(xml_data[["friends"]])
  
  if(length(usuarios) > maxAmigos){
      maxAmigos<-length(usuarios)
      usuarioMaximo<-usuario
  }
  
  for(i in 0:length(usuarios)){
    if(!is.element(usuarios[[i]][[1]], listaUsuarios)){
      append(listaUsuarios,usuarios[[i]][[1]])
    }
  }
  count<-count+1
}