#!/bin/bash

####
# Titulo: Bash para calcular mediante blupf90 los valores genéticos en datos parciales y completos para el caracter peso a los 365 días de edad.
# Autor(es): Jorge Leonardo López Martínez; Cristina Meneses González; Marisol Londoño Gil.
# Requerimientos: renumf90, blupf90+.
####

# Conjunto de datos completo

cd ../Datos/eva_genomica/Beagle_50K/peso_365/Completo

echo "DATAFILE
P365.txt
TRAITS
2
FIELDS_PASSED TO OUTPUT

WEIGHT(S)

RESIDUAL_VARIANCE
1.0
EFFECT
3 cross alpha # Grupo de edad a los 365 días de edad.
EFFECT
4 cross alpha # Grupo de comparación (cebadero-año-mes de entrada al cebadero).
EFFECT
5 cov # Peso de entrada al cebadero como covariable.
EFFECT
6 cov # Días en el cebadero como covariable.
EFFECT
1 cross alpha # Posición del individuo.
RANDOM
animal
FILE
../../../../Pedigri.txt
FILE_POS
1 2 3
SNP_FILE
../genoP365_2.txt
PED_DEPTH
0
INBREEDING
pedigree
(CO)VARIANCES
1.0
OPTION remove_all_missing" > renum.par

echo renum.par | ../../../../../BLUPF90/renumf90 | tee renum.log

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.
 
echo "OPTION SNP_file ../genoP365_2.txt
OPTION saveCleanSNPs
OPTION createGInverse 0
OPTION createA22Inverse 0
OPTION createGimA22i 0" >> renf90.par

echo renf90.par | ../../../../../BLUPF90/preGSf90 | tee pregs.log

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.

echo "OPTION SNP_file ../genoP365_2.txt_clean
OPTION method VCE
OPTION sol se
OPTION no_quality_control
OPTION verify_parentage 3
OPTION store_accuracy 5
OPTION acctype 1.0" >> renf90.par

echo renf90.par | ../../../../../BLUPF90/blupf90+ | tee blup.log

cd -

# Conjunto de datos parcial

cd ../Datos/eva_genomica/Beagle_50K/peso_365/Parcial

echo "DATAFILE
P365.txt
TRAITS
2
FIELDS_PASSED TO OUTPUT

WEIGHT(S)

RESIDUAL_VARIANCE
1.0
EFFECT
3 cross alpha # Grupo de edad a los 365 días de edad.
EFFECT
4 cross alpha # Grupo de comparación (cebadero-año-mes de entrada al cebadero).
EFFECT
5 cov # Peso de entrada al cebadero como covariable.
EFFECT
6 cov # Días en el cebadero como covariable.
EFFECT
1 cross alpha # Posición del individuo.
RANDOM
animal
FILE
../../../../Pedigri.txt
FILE_POS
1 2 3
SNP_FILE
../genoP365_2.txt
PED_DEPTH
0
INBREEDING
pedigree
(CO)VARIANCES
1.0
OPTION remove_all_missing" > renum.par

echo renum.par | ../../../../../BLUPF90/renumf90 | tee renum.log

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.
 
echo "OPTION SNP_file ../genoP365_2.txt
OPTION saveCleanSNPs
OPTION createGInverse 0
OPTION createA22Inverse 0
OPTION createGimA22i 0" >> renf90.par

echo renf90.par | ../../../../../BLUPF90/preGSf90 | tee pregs.log

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.

echo "OPTION SNP_file ../genoP365_2.txt_clean
OPTION method VCE
OPTION sol se
OPTION no_quality_control
OPTION verify_parentage 3
OPTION store_accuracy 5
OPTION acctype 1.0" >> renf90.par

#echo renf90.par | ../../../../../BLUPF90/blupf90+ | tee blup.log

cd -
