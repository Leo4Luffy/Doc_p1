ulimit -s unlimited

#!/bin/bash

####
# Titulo: Bash para calcular mediante blupf90 los valores genéticos para el caracter peso al destete.
# Autor(es): Jorge Leonardo López Martínez; Cristina Meneses González; Marisol Londoño Gil.
# Requerimientos: renumf90, gibbsf90+.
####

# Conjunto de datos completo

cd ../../eva_genetica/Datos/eva_tradicional/peso_Dtte/Completo/

echo "DATAFILE
pDtte.txt
TRAITS
2
FIELDS_PASSED TO OUTPUT

WEIGHT(S)

RESIDUAL_VARIANCE
1.0
EFFECT
3 cov # Edad al destete como covariable.
EFFECT
4 cross alpha # Sexo del individuo como efecto fijo.
EFFECT
5 cross alpha # Edad de la madre (clasificado en seis grupos) como efecto fijo.
EFFECT
6 cross alpha # Grupo de comparación como efecto fijo.
EFFECT
1 cross alpha # Posición del individuo.
RANDOM
animal
OPTIONAL
mat mpe
FILE
../../Pedigri.txt
FILE_POS
1 2 3
PED_DEPTH
0
(CO)VARIANCES
1.0   0.1    
0.1   1.0
(CO)VARIANCES_MPE
1.0
OPTION remove_all_missing" > renum.par

echo renum.par | ../../../../BLUPF90/renumf90 | tee renum.log

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.

echo "OPTION solution mean
OPTION save_halfway_samples 10000
OPTION no_quality_control
OPTION verify_parentage 3" >> renf90.par

../../../../BLUPF90/gibbsf90+ <<AA > gibbs.log
renf90.par
200000 50000
50
AA

cd -

# Conjunto de datos parcial

cd ../../eva_genetica/Datos/eva_tradicional/peso_Dtte/Parcial/

echo "DATAFILE
pDtte.txt
TRAITS
2
FIELDS_PASSED TO OUTPUT

WEIGHT(S)

RESIDUAL_VARIANCE
1.0
EFFECT
3 cov # Edad al destete como covariable.
EFFECT
4 cross alpha # Sexo del individuo como efecto fijo.
EFFECT
5 cross alpha # Edad de la madre (clasificado en seis grupos) como efecto fijo.
EFFECT
6 cross alpha # Grupo de comparación como efecto fijo.
EFFECT
1 cross alpha # Posición del individuo.
RANDOM
animal
OPTIONAL
mat mpe
FILE
../../Pedigri.txt
FILE_POS
1 2 3
PED_DEPTH
0
(CO)VARIANCES
1.0   0.1    
0.1   1.0
(CO)VARIANCES_MPE
1.0
OPTION remove_all_missing" > renum.par

echo renum.par | ../../../../BLUPF90/renumf90 | tee renum.log

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.

echo "OPTION solution mean
OPTION save_halfway_samples 10000
OPTION no_quality_control
OPTION verify_parentage 3" >> renf90.par

../../../../BLUPF90/gibbsf90+ <<AA > gibbs.log
renf90.par
200000 50000
50
AA

cd -
