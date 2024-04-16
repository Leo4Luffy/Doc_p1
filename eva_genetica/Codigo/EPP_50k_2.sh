ulimit -s unlimited

#!/bin/bash

####
# Titulo: Bash para relanzar el muestreo de gibbs en datos parciales y completos para el caracter edad al primer parto.
# Autor(es): Jorge Leonardo López Martínez; Cristina Meneses González; Marisol Londoño Gil.
# Requerimientos: renumf90, gibbsf90.
####

# Conjunto de datos completo

cd ../../eva_genetica/Datos/eva_genomica/Beagle_50K/Edad_Primer_Parto/Completo

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.

echo "OPTION cont 1
OPTION save_halfway_samples 10000" >> renf90.par

../../../../../BLUPF90/gibbsf90+ <<AA > gibbs.log
renf90.par
100000 10000
50
AA

cd -

# Conjunto de datos parcial

cd ../../eva_genetica/Datos/eva_genomica/Beagle_50K/Edad_Primer_Parto/Parcial

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.

echo "OPTION cont 1
OPTION save_halfway_samples 10000" >> renf90.par

../../../../../BLUPF90/gibbsf90+ <<AA > gibbs.log
renf90.par
100000 10000
50
AA

cd -
