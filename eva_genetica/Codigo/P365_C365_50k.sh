#!/bin/bash

####
# Titulo: Bash para calcular mediante blupf90 los valores genéticos en datos parciales y completos para el bi-caracter peso y crecimiento a los 365 días de edad.
# Autor(es): Jorge Leonardo López Martínez; Cristina Meneses González.
# Requerimientos: renumf90, blupf90+.
####

# Conjunto de datos completo

cd ../Datos/eva_genomica/Beagle_50K/P365_C365/Completo

echo "DATAFILE
P365_C365.txt
TRAITS
2 3
FIELDS_PASSED TO OUTPUT

WEIGHT(S)

RESIDUAL_VARIANCE
1.0 0.1
0.1 1.0
EFFECT
4 4 cross alpha # Grupo de edad a los 365 días de edad.
EFFECT
5 5 cross alpha # Grupo de comparación (cebadero-año-mes de entrada al cebadero).
EFFECT
6 6 cov # Peso de entrada al cebadero como covariable.
EFFECT
7 7 cov # Días en el cebadero como covariable.
EFFECT
1 1 cross alpha # Posición del individuo.
RANDOM
animal
FILE
../../../../Pedigri.txt
FILE_POS
1 2 3
SNP_FILE
../genoP365_C365_2.txt
PED_DEPTH
0
INBREEDING
pedigree
(CO)VARIANCES
1.0 0.1
0.1 1.0
OPTION method VCE
OPTION sol se
OPTION callrate 0.00
OPTION callrateAnim 0.00
OPTION minfreq 0.00
OPTION verify_parentage 3
OPTION store_accuracy 5
OPTION acctype 1.0
OPTION remove_all_missing" > renum.par

echo renum.par | ../../../../../BLUPF90/renumf90 | tee renum.log

echo renf90.par | ../../../../../BLUPF90/blupf90+ | tee blup.log

cd -

# Conjunto de datos parcial

cd ../Datos/eva_genomica/Beagle_50K/P365_C365/Parcial

echo "DATAFILE
P365_C365.txt
TRAITS
2 3
FIELDS_PASSED TO OUTPUT

WEIGHT(S)

RESIDUAL_VARIANCE
1.0 0.1
0.1 1.0
EFFECT
4 4 cross alpha # Grupo de edad a los 365 días de edad.
EFFECT
5 5 cross alpha # Grupo de comparación (cebadero-año-mes de entrada al cebadero).
EFFECT
6 6 cov # Peso de entrada al cebadero como covariable.
EFFECT
7 7 cov # Días en el cebadero como covariable.
EFFECT
1 1 cross alpha # Posición del individuo.
RANDOM
animal
FILE
../../../../Pedigri.txt
FILE_POS
1 2 3
SNP_FILE
../genoP365_C365_2.txt
PED_DEPTH
0
INBREEDING
pedigree
(CO)VARIANCES
1.0 0.1
0.1 1.0
OPTION method VCE
OPTION sol se
OPTION callrate 0.00
OPTION callrateAnim 0.00
OPTION minfreq 0.00
OPTION verify_parentage 3
OPTION store_accuracy 5
OPTION acctype 1.0
OPTION remove_all_missing" > renum.par

echo renum.par | ../../../../../BLUPF90/renumf90 | tee renum.log

echo renf90.par | ../../../../../BLUPF90/blupf90+ | tee blup.log

cd -
