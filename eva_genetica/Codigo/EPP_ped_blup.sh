ulimit -s unlimited

#!/bin/bash

####
# Titulo: Bash para calcular mediante blupf90 los valores genéticos para el caracter edad al primer parto.
# Autor(es): Jorge Leonardo López Martínez; Cristina Meneses González; Marisol Londoño Gil.
# Requerimientos: renumf90, gibbsf90+.
####

cd ../../eva_genetica/Datos/eva_tradicional/Edad_Primer_Parto_blup/Completo/

echo "DATAFILE
EPP.txt
TRAITS
2
FIELDS_PASSED TO OUTPUT

WEIGHT(S)

RESIDUAL_VARIANCE
1.0
EFFECT
3 cross alpha # Grupo de comparación para la edad al primer parto. Se trata como aleatorio para los dos caracteres de fertilidad.
RANDOM
diagonal
(CO)VARIANCES
1.0
EFFECT
4 cross alpha # Identificación del toro (como efecto ambiental permanente del toro o la componente del toro que es común a todas las hembras que se cubren con el mismo reproductor).
RANDOM
diagonal
(CO)VARIANCES
1.0
EFFECT
5 cross alpha # Sexo de la cría en el primer parto.
EFFECT
6 cross alpha # Edad del toro en el primer parto (< 3 años, >= 3 años, < 4 años >= 4 años, < 5 años).
EFFECT
1 cross alpha # Posición del individuo.
RANDOM
animal
FILE
../../Pedigri.txt
FILE_POS
1 2 3
PED_DEPTH
0 # Profundidad de búsqueda de pedigrí (predeterminado igual a 3); todos los pedigríes se cargan si p = 0.
(CO)VARIANCES
1.0
OPTION remove_all_missing" > renum.par

echo renum.par | ../../../../BLUPF90/renumf90 | tee renum.log

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.

echo "OPTION verify_parentage 3
OPTION store_accuracy 5
OPTION acctype 1.0" >> renf90.par

echo renf90.par | ../../../../BLUPF90/blupf90+ | tee blup.log

cd -
