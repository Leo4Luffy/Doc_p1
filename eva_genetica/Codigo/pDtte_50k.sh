#!/bin/bash

####
# Titulo: Bash para calcular mediante blupf90 los valores genéticos en datos parciales y completos para el caracter peso al destete.
# Autor(es): Jorge Leonardo López Martínez; Cristina Meneses González; Marisol Londoño Gil.
# Requerimientos: renumf90, blupf90+.
####

# Conjunto de datos completo

cd ../Datos/eva_genomica/Beagle_50K/peso_Dtte/Completo

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
../../../../Pedigri.txt
FILE_POS
1 2 3
SNP_FILE
../genoPdtte_2.txt
PED_DEPTH
0
INBREEDING
pedigree
(CO)VARIANCES
1.0   0.1    
0.1   1.0
(CO)VARIANCES_MPE
1.0
OPTION remove_all_missing" > renum.par

echo renum.par | ../../../../../BLUPF90/renumf90 | tee renum.log

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.
 
echo "OPTION SNP_file ../genoPdtte_2.txt
OPTION saveCleanSNPs
OPTION excludeSample 2156
OPTION createGInverse 0
OPTION createA22Inverse 0
OPTION createGimA22i 0" >> renf90.par

echo renf90.par | ../../../../../BLUPF90/preGSf90 | tee pregs.log # Hay dos individuos con genotipos duplicados. Se elimina uno de ellos, el que esta en la fila o linea 2156 mediante la opción "excludeSample".

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.

echo "OPTION SNP_file ../genoPdtte_2.txt_clean
OPTION method VCE
OPTION sol se
OPTION no_quality_control
OPTION verify_parentage 3
OPTION store_accuracy 5
OPTION acctype 1.0" >> renf90.par

echo renf90.par | ../../../../../BLUPF90/blupf90+ | tee blup.log

cd -

# Conjunto de datos parcial

cd ../Datos/eva_genomica/Beagle_50K/peso_Dtte/Parcial

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
../../../../Pedigri.txt
FILE_POS
1 2 3
SNP_FILE
../genoPdtte_2.txt
PED_DEPTH
0
INBREEDING
pedigree
(CO)VARIANCES
1.0   0.1    
0.1   1.0
(CO)VARIANCES_MPE
1.0
OPTION remove_all_missing" > renum.par

echo renum.par | ../../../../../BLUPF90/renumf90 | tee renum.log

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.
 
echo "OPTION SNP_file ../genoPdtte_2.txt
OPTION saveCleanSNPs
OPTION createGInverse 0
OPTION createA22Inverse 0
OPTION createGimA22i 0" >> renf90.par

echo renf90.par | ../../../../../BLUPF90/preGSf90 | tee pregs.log # Hay dos individuos con genotipos duplicados. Se elimina uno de ellos, el que esta en la fila o linea 2156 mediante la opción "excludeSample" a continuación.

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.

echo "OPTION SNP_file ../genoPdtte_2.txt_clean
OPTION excludeSample 2156
OPTION method VCE
OPTION sol se
OPTION no_quality_control
OPTION verify_parentage 3
OPTION store_accuracy 5
OPTION acctype 1.0" >> renf90.par

echo renf90.par | ../../../../../BLUPF90/blupf90+ | tee blup.log

cd -
