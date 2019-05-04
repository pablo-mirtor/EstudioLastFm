#Script2
#Obtener una lista de usuarios con los que se va a realizar el estudio.

apiKey<-"&api_key=82b23813669e5d6580f8a13e66e258e3"
enlaceUsuario<-"http://ws.audioscrobbler.com/2.0/?method=user.getfriends&user="
listaUsuarios<-c('pabloskink')
maximo<-10000
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
  
  
  if(!is.character(xml_data)){ #no es vacío
    usuarios <- as.list(xml_data[["friends"]])
    amigosTotal<-xml_data[["friends"]][[".attrs"]][["total"]]
    totalPages<-xml_data[["friends"]][[".attrs"]][["totalPages"]]
    
    for(i in 1:totalPages){
      enlace<-paste(enlaceUsuario,usuario,"&page=",i,apiKey,sep="")
      datos<-xmlParse(enlace)
      xml_data <- xmlToList(datos)
      usuarios <- as.list(xml_data[["friends"]])
      amigos<-length(usuarios) - 1
      for(j in 1:amigos){
        if(!is.element(usuarios[[j]][[1]], listaUsuarios)){
          listaUsuarios<-c(listaUsuarios,usuarios[[j]][[1]])
        }
      }
    }
  }
  count<-count+1
}

write.csv(listaUsuarios, "usuarios.csv") #guardamos la lista en un fichero .csv

