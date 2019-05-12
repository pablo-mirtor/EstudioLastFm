#Script 3
#Obtener artistas más escuchados de cada usuario y realizar clustering
apiKey<-"&api_key=82b23813669e5d6580f8a13e66e258e3"
enlaceArtistas<-"http://ws.audioscrobbler.com/2.0/?method=user.gettopartists&limit=10&user="
fichero<-"usuarios.csv"

if (!require(XML)) install.packages("XML")
require(XML)

if(!file.exists(fichero)){
  
  print("No se ha encontrado el fichero de los usuarios")
  
} else {
  
  datosCsv <- read.csv(file=fichero, header=TRUE, sep=",")
  kmeans.result <- kmeans(datosCsv, 3)
  print(datosCsv[[1]][[2]])
  for(i in 1:100){
    usuario<-datosCsv[[1]][[i]]
    enlace<-paste(enlaceArtistas,usuario,apiKey,sep="")
    datosXml<-xmlParse(enlace)
    xml_data <- xmlToList(datosXml)
    artistas <- as.list(xml_data[["topartists"]])
    numArtistas<-length(artistas) - 1
    for(j in 1:numArtistas){
      print(artistas[[j]][["name"]])
    }
  }
}