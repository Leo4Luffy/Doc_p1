ulimit -s unlimited

#!/bin/bash

####
# Titulo: Bash para calcular mediante blupf90 los valores genéticos para el caracter intervalor entre el parto uno y dos.
# Autor(es): Jorge Leonardo López Martínez; Cristina Meneses González; Marisol Londoño Gil.
# Requerimientos: renumf90, gibbsf90+.
####

cd ../../eva_genetica/Datos/eva_tradicional/intervalo_P1_P2/

echo "DATAFILE
IEP.txt
TRAITS
2
FIELDS_PASSED TO OUTPUT

WEIGHT(S)

RESIDUAL_VARIANCE
1.0
EFFECT
3 cross alpha # Edad al primer parto como efecto para el IEP (edad al primer parto de la hembra clasificada en tres grupos: < 2.5 años, >= 2.5 años, <= 3 años, > 3 años).
EFFECT
4 cross alpha # Grupo de comparación para el intervalo entre los partos uno y dos. Se trata como aleatorio para los dos caracteres de fertilidad.
RANDOM
diagonal
(CO)VARIANCES
1.0
EFFECT
5 cross alpha # Identificación del toro (como efecto ambiental permanente del toro o la componente del toro que es común a todas las hembras que se cubren con el mismo reproductor).
RANDOM
diagonal
(CO)VARIANCES
1.0
EFFECT
6 cross alpha # Sexo de la cría en el segundo parto.
EFFECT
7 cross alpha # Edad del toro en el segundo parto (< 3 años, >= 3 años, < 4 años >= 4 años, < 5 años).
EFFECT
8 cross alpha # Raza del toro (Avileña Negra-Ibérica, Charoles, Limousín).
EFFECT
1 cross alpha # Posición del individuo.
RANDOM
animal
FILE
../Pedigri.txt
FILE_POS
1 2 3
PED_DEPTH
0 # Profundidad de búsqueda de pedigrí (predeterminado igual a 3); todos los pedigríes se cargan si p = 0.
(CO)VARIANCES
1.0
OPTION remove_all_missing" > renum.par

echo renum.par | ../../../BLUPF90/renumf90 | tee renum.log

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.

echo "OPTION solution mean
OPTION save_halfway_samples 10000
OPTION no_quality_control
OPTION verify_parentage 3" >> renf90.par

../../../BLUPF90/gibbsf90+ <<AA > gibbs.log
renf90.par
200000 50000
50
AA

cd -
