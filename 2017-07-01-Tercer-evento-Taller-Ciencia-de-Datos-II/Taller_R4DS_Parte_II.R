###########################################################
# C�digo para el Taller R para Ciencia de Datos - Parte II #
###########################################################

library(tidyverse)

###############################################
###############################################
# clase 2:
# Retomemos la clase 1:
# recordemos c�mo hacemos el 1er grafico de la seccion 3.3?
# veniamos usando los datos de autos mpg
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# Veamos c�mo hacemos el mismo gr�fico con R base:


# primero, veamos los par�metros seteados del plot:
# son todas las caracteristicas de los graficos que
# estan seteadas por default
par()
# valor por default de los margenes del plot:
par(mar=c(5.1, 4.1, 4.1, 2.1))

plot(mpg$displ,mpg$hwy)

# podemos mejorarlo, por ejemplo, usando los mimmos
# simbolos para los puntos:
plot(mpg$displ,mpg$hwy,pch=19,cex=0.75)

# de esta forma agregamos una grilla al plot:
grid(col = "grey")

# otra opcion es hacerlo dentro de la misma sentencia
# del plot:
plot(mpg$displ,mpg$hwy,pch=19,cex=0.75,grid())

# faltan los labels:
plot(mpg$displ,mpg$hwy,pch=19,cex=0.75,grid(),xlab = "displ",ylab="hwy")

# podemos agregarle un titulo?
plot(mpg$displ,mpg$hwy,pch=19,cex=0.75,grid(),xlab = "displ",ylab="hwy",main = "datos mpg")


# c�mo reproducimos el primer grafico de 3.3?
# usando colores para diferentes "class" de autos
plot(mpg$displ[mpg$class!="2seater"],mpg$hwy[mpg$class!="2seater"],pch=19,cex=0.75,grid(),xlab = "displ",ylab="hwy")
points(mpg$displ[mpg$class=="2seater"],mpg$hwy[mpg$class=="2seater"],pch=19,cex=1,col="red")


# esto es algo �til para datos categ�ricos: 
# una forma f�cil de hacer un gr�fico para 
# cada categor�a con ggplot:

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# estamos eligiendo la categor�a class, veamos un poco 
# esta variable:
mpg$class

# Veamos cu�ntos datos tenemos en la variable:
length(mpg$class)

# estamos usando la funcion length()
# recordemos que identificamos una funcion por los 
# parentesis () que esperan argumentos.
# la funcion puede no requerir argumentos, pero los () est�n igual
# por ejemplo help.start()

# si queremos un resumen de la variable:
str(mpg$class)

# veamos los valores que toma la variable:
table(mpg$class)

# y en general un resumen del data frame
str(mpg)

# podemos cambiar parametros del grafico, 
# como el valor de nrow:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 3)

# el argumento de facet_wrap debe ser una formula, 
# por eso empieza con el s�mbolo ~. Debe ser seguido 
# de una variable discreta.

# qu� pasa en este caso:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

# Que significan las celdas vacias en el gr�fico?
# analicemos las variables drv y cyl
# recordemos qu� significan esas variables
help(mpg)
table(mpg$drv,mpg$cyl)

# si solo queremos distinguir por una variable:
# qu� hace el "." (punto)?:
# (permite eligir por filas o columnas)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(cyl ~ .)

# si queremos buscar ayuda de la funcion
?facet_wrap

# Veamos un ejemplo de como se puede usar 
# la misma informacion "cruda" para graficar 
# diferentes cosas usando algun metodo de R, 
# en este caso ggplot2:

# Primero el grafico de puntos que ya conocemos:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# y ahora otro tipo de gr�fico
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

# qu� est� graficando? es la misma informaci�n?

# podemos verlos juntos?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))+
  geom_smooth(mapping = aes(x = displ, y = hwy))

# lo discutimos un poco?
# los puntos x e y usados son los mismos
# usan diferentes objetos geom�tricos que luego
# se grafica usando plot
# geom_smooth hace algo con los datos, est�
# aplicando un m�todo para obtener una curva suave
# necesitamos saber qu� hace la funci�n, qu� supone, etc.


# veamos otra opci�n de esta funci�n (agregando linetype = drv)
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

# qu� est� haciendo?
table(mpg$drv)


# podemos marcar los diferentes puntos usando 
# diferentes colores:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color=drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv,color=drv))

# est� trazando una curva suave para cada grupo de datos de
# acuerdo a la clase drv

# no hace falta escribir la misma informacion varias veces:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

# y tambien podemos simplificar el c�digo que 
# distingue puntos (pero distingue siempre, 
# en todas las acciones).
ggplot(data = mpg,mapping = aes(x = displ, y = hwy, color=drv)) + 
  geom_point() +
  geom_smooth()

# podemos hacer el ajuste s�lo para un subconjunto
# de los datos:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

# grafiquemos solo los puntos que vamos a usar
# para hacer el ajuste:
ggplot(data = filter(mpg, class == "subcompact"), mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

# podemos graficar puntos y curvas del mismo color?
ggplot(data = filter(mpg, class == "subcompact"), mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class),color="red") + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE,color="red")


# Ejercicio: qu� hace este codigo
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# como hacemos para que no haya legend en el grafico?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point(show.legend = FALSE) + 
  geom_smooth(se = FALSE,show.legend = FALSE)

# que hace el argumento "se"
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point(show.legend = FALSE) + 
  geom_smooth(se = TRUE,show.legend = FALSE)


# Veamos otro tipo d gr�ficos:
# De barras:
# tomemos los datos que propone el libro (diamantes)
diamonds

# veamos informaci�n del data frame:
str(diamonds)

# gr�fico de barras de la variable cut:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

# podemos ver esta informaci�n?
table(diamonds$cut)

# c�mo har�amos el mismo gr�fico en R base?
a<-table(diamonds$cut)
ta<-sort(table(a),decreasing = T)
bar<-barplot(a,main="Variable cut (diamonds)",las=2,cex.names=0.75,xlab="",ylab="frecuencia")

# podemos cambiar el tama�o de los ticks
bar<-barplot(a,main="Variable cut (diamonds)",las=2,cex.names=0.75,xlab="",ylab="frecuencia",cex.axis=0.7)

# podemos agregarle informaci�n del valor
# de cada barra
text(bar[,1],1000,a,cex=0.7)

# qu� contiene la variable bar? y a?
# c�mo tomamos el primer elemento de la tabla?
a[1]

# si queremos graficar proporcion en vez de 
# frecuencia:
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut,group = 1))


# Ejercicio
# Podemos generar un conjunto de datos que 
# nos interese y graficar las barras
# ejemplo...
# en que viajamos hasta ac� hoy?
# (cuantas caminando, subte, cole, auto, etc)

# una forma de cargar datos:
Rdatos <- tribble(
  ~viaje, ~freq,
  "auto", 16,
  "pie",  4,
  "cole", 12,
  "tren", 10,
  "subte",20
)

# qu� gr�fico obtenemos? alguna diferencia
# con el anterior?
ggplot(data = Rdatos) +
  geom_bar(mapping = aes(x = viaje, y = freq), stat = "identity")


# Veamos otro tipo de gr�fico que resume
# informacion de las variables:
# qu� hace esta sentencia?
ggplot(data = diamonds) + 
stat_summary(
  mapping = aes(x = cut, y = depth),
  fun.ymin = min,
  fun.ymax = max,
  fun.y = median
)

# min, max, median son funciones de R:
summary(diamonds$depth[diamonds$cut=="Fair"])
summary(diamonds$depth[diamonds$cut=="Good"])

# c�mo podemos cambiar mediana por media?

# A veces queremos hacer un grafico a partir
# de una tabla de doble entrada (dos categorias)
# por ejemplo nos interesa cut y clarity de 
# los diamantes

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

# veamos la tabla que est� graficando:
table(diamonds$cut,diamonds$clarity)

#de otra forma:
ta <- table(diamonds$cut,diamonds$clarity)
bar<-barplot(ta,main="Diamantes",las=2,cex.names=0.75,xlab="",ylab="frecuencia",cex.axis=0.7)

# qu� pas� con los colores si no le decimos nada?
bar<-barplot(ta,col=topo.colors(5),main="Diamantes",las=2,cex.names=0.75,xlab="",ylab="frecuencia",cex.axis=0.7)

# qu� hace la funci�n topo.colors()?: 
topo.colors(5)

# otra opcion para crear paleta de colores:
rainbow(5)

# por qu� el argumento que le damos es 5?

bar<-barplot(ta,col=rainbow(5),main="Diamantes",las=2,cex.names=0.75,xlab="",ylab="frecuencia",cex.axis=0.7)

# si queremos ver los posibles valores de cut y clarity:
rownames(ta)
colnames(ta)

# qu� es ta? (me olvid�)

# y qu� tipo de objeto es?
str(ta)
typeof(ta)

# tenemos que agregarle un legend a mano:
bar<-barplot(ta,col=rainbow(5),main="Diamantes",las=2,cex.names=0.75,xlab="",ylab="frecuencia",cex.axis=0.7)
legend("topright",leg=rownames(ta),cex=0.5,col=rainbow(5),fill=rainbow(5))

# si queremos guardar el gr�fico en un pdf desde la consola:
pdf("diamantes.pdf")
bar<-barplot(ta,col=rainbow(5),main="Diamantes",las=2,cex.names=0.75,xlab="",ylab="frecuencia",cex.axis=0.7)
legend("topright",leg=rownames(ta),cex=0.5,col=rainbow(5),fill=rainbow(5))
dev.off()

# si le queremos agregar label al eje x
bar<-barplot(ta,col=rainbow(5),main="Diamantes",las=2,cex.names=0.75,xlab="cut",ylab="frecuencia",cex.axis=0.7)
legend("topright",leg=rownames(ta),cex=0.6,fill=rainbow(5))

# tambi�n podemos graficar en barritas para cada categor�a
bar<-barplot(ta,col=rainbow(5),main="Diamantes",las=2,cex.names=0.75,xlab="cut",ylab="frecuencia",cex.axis=0.7,beside=T)
legend("topright",leg=rownames(ta),cex=0.6,fill=rainbow(5))


# podemos hacer otra cosa en vez de "decirle" que
# son 5 colores?
# probemos la funcion
n <- length(rownames(ta))
bar<-barplot(ta,col=rainbow(n),main="Diamantes",las=2,cex.names=0.75,xlab="cut",ylab="frecuencia",cex.axis=0.7,beside=T)
legend("topright",leg=rownames(ta),cex=0.6,fill=rainbow(n))


# veamos estas dos variantes:
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")

ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")

# y como veiamos en R base, tambien tenemos la
# opcion de varias lineas verticales, usando
# tambien el argumento position
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

# veamos una normalizacion usando el argumento
#  position = "fill":
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")


