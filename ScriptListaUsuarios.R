#Script2
#Obtener una lista de usuarios con los que se va a realizar el estudio.

apiKey<-"&api_key=82b23813669e5d6580f8a13e66e258e3"
enlaceAmigos<-"http://ws.audioscrobbler.com/2.0/?method=user.getfriends&user="
enlaceUsuario<-"http://ws.audioscrobbler.com/2.0/?method=user.getinfo&user="
listaUsuarios<-c('pabloskink')
listaPaises<-c('Spain')
maximo<-100000
usuarioMaximo<-''
maxAmigos<-0
nombreFichero<-"usuarios.csv"
if (!require(XML)) install.packages("XML")
require(XML)
if (!require(httr)) install.packages("httr")
require(httr)
count<-1
sink(nombreFichero)
cat(paste("usuario","pais \n",sep=","))


while(length(listaUsuarios) < maximo){
  usuario<-listaUsuarios[count]
  enlace<-paste(enlaceAmigos,usuario,apiKey,sep="")
  datos<-xmlParse(enlace)
  xml_data <- xmlToList(datos)
  
  
  if(!is.character(xml_data)){ #no es vacío
    usuarios <- as.list(xml_data[["friends"]])
    amigosTotal<-xml_data[["friends"]][[".attrs"]][["total"]]
    totalPages<-xml_data[["friends"]][[".attrs"]][["totalPages"]]
    
   # for(i in 1:totalPages){
      enlace<-paste(enlaceAmigos,usuario,"&page=",1,apiKey,sep="")
      datos<-xmlParse(enlace)
      xml_data <- xmlToList(datos)
      usuarios <- as.list(xml_data[["friends"]])
      amigos<-length(usuarios) - 1
      for(j in 1:amigos){
        if(!is.element(usuarios[[j]][[1]], listaUsuarios)){
          
          enlaceDetalle<-paste(enlaceUsuario,usuarios[[j]][[1]],apiKey,sep="")
          
          response<- GET(enlaceDetalle)
          if (response$status_code==200){ # HTTP request failed!!
            datos1<-xmlParse(enlaceDetalle)
            xml_data1 <- xmlToList(datos1)
            pais<-xml_data1[["user"]][["country"]]
            playcount<-xml_data1[["user"]][["playcount"]]
            if(pais!="None" && playcount > 1000){
              listaUsuarios<-c(listaUsuarios,usuarios[[j]][[1]])
              cat(paste(usuarios[[j]][[1]],pais,sep=","))
              cat('\n')
            }
          }
       
        }
      }
  #  }
  }
  count<-count+1
}
sink()
print(enlaceDetalle)
