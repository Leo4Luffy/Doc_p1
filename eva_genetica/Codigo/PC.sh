#!/bin/bash

####
# Titulo: Bash para calcular mediante blupf90 los valores genéticos en datos parciales y completos para el caracter peso en la canal.
# Autor(es): Jorge Leonardo López Martínez; Cristina Meneses González.
# Requerimientos: renumf90, blupf90+.
####

# Conjunto de datos completo

cd ../Datos/eva_genomica/Beagle_50K/peso_canal/Completo

echo "DATAFILE
PC.txt
TRAITS
2
FIELDS_PASSED TO OUTPUT

WEIGHT(S)

RESIDUAL_VARIANCE
1.0
EFFECT
3 cross alpha # Sexo del individuo.
EFFECT
4 cross alpha # Edad en la canal (definido en tres niveles: <= 12.3 meses, > 12.3 meses, <= 15.1 meses, > 15.1 meses).
EFFECT
5 cross alpha # Grupo de comparación para el peso en la canal (cebadero-matadero-año de sacrificio).
EFFECT
1 cross alpha # Posición del individuo.
RANDOM
animal
FILE
../../../../Pedigri.txt
FILE_POS
1 2 3
SNP_FILE
../genoPC_2.txt
PED_DEPTH
0
INBREEDING
pedigree
(CO)VARIANCES
1.0
OPTION method VCE
OPTION sol se
OPTION callrate 0.00
OPTION callrateAnim 0.00
OPTION minfreq 0.00
OPTION verify_parentage 3
OPTION store_accuracy 5
OPTION acctype 1.0
OPTION remove_all_missing
OPTION alpha_size 25" > renum.par

echo renum.par | ../../../../../BLUPF90/renumf90 | tee renum.log

echo renf90.par | ../../../../../BLUPF90/blupf90+ | tee blup.log

cd -

# Conjunto de datos parcial

cd ../Datos/eva_genomica/Beagle_50K/peso_canal/Parcial

echo "DATAFILE
PC.txt
TRAITS
2
FIELDS_PASSED TO OUTPUT

WEIGHT(S)

RESIDUAL_VARIANCE
1.0
EFFECT
3 cross alpha # Sexo del individuo.
EFFECT
4 cross alpha # Edad en la canal (definido en tres niveles: <= 12.3 meses, > 12.3 meses, <= 15.1 meses, > 15.1 meses).
EFFECT
5 cross alpha # Grupo de comparación para el peso en la canal (cebadero-matadero-año de sacrificio).
EFFECT
1 cross alpha # Posición del individuo.
RANDOM
animal
FILE
../../../../Pedigri.txt
FILE_POS
1 2 3
SNP_FILE
../genoPC_2.txt
PED_DEPTH
0
INBREEDING
pedigree
(CO)VARIANCES
1.0
OPTION method VCE
OPTION sol se
OPTION callrate 0.00
OPTION callrateAnim 0.00
OPTION minfreq 0.00
OPTION verify_parentage 3
OPTION store_accuracy 5
OPTION acctype 1.0
OPTION remove_all_missing
OPTION alpha_size 25" > renum.par

echo renum.par | ../../../../../BLUPF90/renumf90 | tee renum.log

echo renf90.par | ../../../../../BLUPF90/blupf90+ | tee blup.log

cd -
