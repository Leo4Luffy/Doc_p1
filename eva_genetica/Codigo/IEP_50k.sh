#!/bin/bash

####
# Titulo: Bash para calcular mediante blupf90 los valores genéticos en datos parciales y completos para el caracter intervalor entre el parto uno y dos.
# Autor(es): Jorge Leonardo López Martínez; Cristina Meneses González; Marisol Londoño Gil.
# Requerimientos: renumf90, blupf90+.
####

# Conjunto de datos completo

cd ../Datos/eva_genomica/Beagle_50K/intervalo_P1_P2/Completo

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
4 cross alpha # Grupo de comparación para el intervalo entre los partos uno y dos.
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
../../../Pedigri.txt
FILE_POS
1 2 3
SNP_FILE
../../Genotipos_2.txt
PED_DEPTH
0
INBREEDING
pedigree
(CO)VARIANCES
1.0
OPTION remove_all_missing" > renum.par

echo renum.par | ../../../../../BLUPF90/renumf90 | tee renum.log

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.
 
echo "OPTION SNP_file ../../Genotipos_2.txt
OPTION excludeSample 2383
OPTION saveCleanSNPs
OPTION createGInverse 0
OPTION createA22Inverse 0
OPTION createGimA22i 0" >> renf90.par

echo renf90.par | ../../../../../BLUPF90/preGSf90 | tee pregs.log # Hay dos individuos con genotipos duplicados. Se elimina uno de ellos, el que esta en la fila o linea 2383 mediante la opción "excludeSample".

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.

echo "OPTION SNP_file ../../Genotipos_2.txt_clean
OPTION method VCE
OPTION sol se
OPTION no_quality_control
OPTION verify_parentage 3
OPTION store_accuracy 5
OPTION acctype 1.0" >> renf90.par

echo renf90.par | ../../../../../BLUPF90/blupf90+ | tee blup.log

cd -

# Conjunto de datos parcial

cd ../Datos/eva_genomica/Beagle_50K/intervalo_P1_P2/Parcial

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
4 cross alpha # Grupo de comparación para el intervalo entre los partos uno y dos.
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
../../../Pedigri.txt
FILE_POS
1 2 3
SNP_FILE
../../Genotipos_2.txt
PED_DEPTH
0
INBREEDING
pedigree
(CO)VARIANCES
1.0
OPTION remove_all_missing" > renum.par

echo renum.par | ../../../../../BLUPF90/renumf90 | tee renum.log

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.
 
echo "OPTION SNP_file ../../Genotipos_2.txt
OPTION excludeSample 2383
OPTION saveCleanSNPs
OPTION excludeSample 1326
OPTION createGInverse 0
OPTION createA22Inverse 0
OPTION createGimA22i 0" >> renf90.par

echo renf90.par | ../../../../../BLUPF90/preGSf90 | tee pregs.log # Hay dos individuos con genotipos duplicados. Se elimina uno de ellos, el que esta en la fila o linea 2383 mediante la opción "excludeSample".

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.

echo "OPTION SNP_file ../../Genotipos_2.txt_clean
OPTION method VCE
OPTION sol se
OPTION no_quality_control
OPTION verify_parentage 3
OPTION store_accuracy 5
OPTION acctype 1.0" >> renf90.par

echo renf90.par | ../../../../../BLUPF90/blupf90+ | tee blup.log

cd -
