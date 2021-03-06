###########################################################
# C�digo para el Taller R para Ciencia de Datos - Parte I #
###########################################################

# Paquetes con los que trabajaremos a lo largo de todo el Taller (no s�lo la
# Parte I) 

# Instalaci�n (s�lo se hace la primera vez que se necesitan los paquetes)

install.packages("tidyverse")
install.packages(c("nycflights13", "gapminder", "Lahman"))

# Para usar un paquete hay que cargarlo durante cada uso. Para eso usamos
# la funci�n library

library(tidyverse)

# Siempre conviene tener los paquetes del tidyverse actualizados
# C�digo para actualizarlos: tidyverse_update()

###############################################################################
# Mi primer c�digo R: R tambi�n es una calculadora

1 + 2

# Si quiero guardar la respuesta

resultado <- 1 + 2 # Qu� apareci� en el panel de arriba a la derecha?
                   # Para tipear " <- " pod�s usar alt y - a la vez. Prob�lo.

# Para ver el resultado

resultado

# Ejercicio: hac� la cuenta que quieras desde el script o directamente desde
# la consola, guardando y sin guardar el resultado

###############################################################################
# Explorando con gr�ficos

# Pregunta: �Los autos con motores grandes usan m�s nafta que los autos con 
# motores chicos? �C�mo es la relaci�n entre el tama�o del motor y el consumo 
# de nafta? �Es positiva? �Negativa? �Lineal? �No lineal?

#### Dataframes

# Vamos a usar la base de datos mpg - miremos de qu� se trata este dataframe

mpg # alternativamente ggplot2::mpg - me asegura que el mpg que uso es del
    # paquete ggplot2

?mpg # abre la documentaci�n sobre mpg abajo a la derecha, donde se explica qu� 
     # es cada variable

# Ejercicio: Cu�ntas filas tiene mpg? Cu�ntas columnas?

# Ejercicio: Qu� describre la variable drv?

#### ggplot

# Para crear un gr�fico de dispersi�n usando mpg que incluya el tama�o del motor
# (displ) en el eje de las x y cantidad de millas por gal�n (hwy) en el eje de 
# las y 

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy))

# Funciona si pruebo otras formas como:??

ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

# o como:??

ggplot(data = mpg) 
    + geom_point(mapping = aes(x = displ, y = hwy))

# Ejercicio: Hac� un gr�fico de dispersi�n de hwy versus cyl

#### Agregado de atributos est�ticos a distintas variables

# Usando colores para identificar las distintas clases de veh�culos (class)

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, color = class))

# Tambi�n pod�s usar distintos niveles de transparencias

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# O distintas formas (Cuidado! SUV no aparece en el gr�fico, se qued� sin forma)

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# En lugar de pintar por clase, pinto todos los puntos de un mismo color

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# Ejercicio: Por qu� en el siguiente gr�fico los puntos no son azules? 
# C�mo lo arreglar�as?

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))

# Qu� pasa si us�s la variable cty (variable continua) para el atributo est�tico 
# color? El c�digo para eso es:

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, color = cty))

# Prob� lo mismo con alpha y shape. C�mo se comparan estos gr�ficos a cuando
# usaste la variable categ�rica class?

# Ejercicio: Mape� la variable cty a los atributos est�ticos color y alpha.

# Ejercicio: Qu� hace el atributo est�tico stroke? Con qu� formas funciona?
# Mostr� un ejemplo. Pista: Us� el comando ?geom_point