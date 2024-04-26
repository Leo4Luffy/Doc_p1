ulimit -s unlimited

#!/bin/bash

####
# Titulo: Bash para calcular mediante blupf90 los valores genéticos en datos parciales y completos para el bi-caracter edad al primer parto e intervalo primer y segundo parto.
# Autor(es): Jorge Leonardo López Martínez; Cristina Meneses González; Marisol Londoño Gil.
# Requerimientos: renumf90, blupf90+.
####

# Conjunto de datos completo

cd ../Datos/eva_genomica/SNP_tags_sing/EPP_IEP/Completo

echo "DATAFILE
EPP_IEP.txt
TRAITS
2 7
FIELDS_PASSED TO OUTPUT

WEIGHT(S)

RESIDUAL_VARIANCE
1.0 0.1
0.1 1.0
EFFECT
3 0 cross alpha # Grupo de comparación para la edad al primer parto. Se trata como aleatorio.
RANDOM
diagonal
(CO)VARIANCES
1.0 0.0
0.0 0.0
EFFECT
4 0 cross alpha # Identificación del toro (como efecto ambiental permanente del toro o la componente del toro que es común a todas las hembras que se cubren con el mismo reproductor).
RANDOM
diagonal
(CO)VARIANCES
1.0 0.0
0.0 0.0
EFFECT
5 0 cross alpha # Sexo de la cría en el primer parto.
EFFECT
6 0 cross alpha # Edad del toro en el primer parto (< 3 años, >= 3 años, < 4 años >= 4 años, < 5 años).
EFFECT
0 8 cross alpha # Edad al primer parto como efecto para el IEP (edad al primer parto de la hembra clasificada en tres grupos: < 2.5 años, >= 2.5 años, <= 3 años, > 3 años).
EFFECT
0 9 cross alpha # Grupo de comparación para el intervalo entre los partos uno y dos.
RANDOM
diagonal
(CO)VARIANCES
0.0 0.0
0.0 1.0
EFFECT
0 10 cross alpha # Identificación del toro (como efecto ambiental permanente del toro o la componente del toro que es común a todas las hembras que se cubren con el mismo reproductor).
RANDOM
diagonal
(CO)VARIANCES
0.0 0.0
0.0 1.0
EFFECT
0 11 cross alpha # Sexo de la cría en el segundo parto.
EFFECT
0 12 cross alpha # Edad del toro en el segundo parto (< 3 años, >= 3 años, < 4 años >= 4 años, < 5 años).
EFFECT
0 13 cross alpha # Raza del toro (Avileña Negra-Ibérica, Charoles, Limousín).
EFFECT
1 1 cross alpha # Posición del individuo.
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
(CO)VARIANCES
1.0 0.1
0.1 1.0
OPTION remove_all_missing" > renum.par

echo renum.par | ../../../../../BLUPF90/renumf90 | tee renum.log

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.
 
echo "OPTION SNP_file ../../Genotipos_2.txt
OPTION saveCleanSNPs
OPTION excludeSample 2383
OPTION createGInverse 0
OPTION createA22Inverse 0
OPTION createGimA22i 0" >> renf90.par

echo renf90.par | ../../../../../BLUPF90/preGSf90 | tee pregs.log # Hay dos individuos con genotipos duplicados. Se elimina uno de ellos, el que esta en la fila o linea 2383 mediante la opción "excludeSample".

sed -i '/OPTION/d' renf90.par # Se insertan nuevas opciones en el renf90.par.

echo "OPTION SNP_file ../../Genotipos_2.txt_clean
OPTION solution mean
OPTION save_halfway_samples 10000
OPTION no_quality_control
OPTION verify_parentage 3" >> renf90.par

../../../../../BLUPF90/gibbsf90+ <<AA > gibbs.log
renf90.par
200000 50000
50
AA

cd -

# Conjunto de datos parcial

cd ../Datos/eva_genomica/SNP_tags_sing/EPP_IEP/Parcial

echo "DATAFILE
EPP_IEP.txt
TRAITS
2 7
FIELDS_PASSED TO OUTPUT

WEIGHT(S)

RESIDUAL_VARIANCE
1.0 0.1
0.1 1.0
EFFECT
3 0 cross alpha # Grupo de comparación para la edad al primer parto. Se trata como aleatorio.
RANDOM
diagonal
(CO)VARIANCES
1.0 0.0
0.0 0.0
EFFECT
4 0 cross alpha # Identificación del toro (como efecto ambiental permanente del toro o la componente del toro que es común a todas las hembras que se cubren con el mismo reproductor).
RANDOM
diagonal
(CO)VARIANCES
1.0 0.0
0.0 0.0
EFFECT
5 0 cross alpha # Sexo de la cría en el primer parto.
EFFECT
6 0 cross alpha # Edad del toro en el primer parto (< 3 años, >= 3 años, < 4 años >= 4 años, < 5 años).
EFFECT
0 8 cross alpha # Edad al primer parto como efecto para el IEP (edad al primer parto de la hembra clasificada en tres grupos: < 2.5 años, >= 2.5 años, <= 3 años, > 3 años).
EFFECT
0 9 cross alpha # Grupo de comparación para el intervalo entre los partos uno y dos.
RANDOM
diagonal
(CO)VARIANCES
0.0 0.0
0.0 1.0
EFFECT
0 10 cross alpha # Identificación del toro (como efecto ambiental permanente del toro o la componente del toro que es común a todas las hembras que se cubren con el mismo reproductor).
RANDOM
diagonal
(CO)VARIANCES
0.0 0.0
0.0 1.0
EFFECT
0 11 cross alpha # Sexo de la cría en el segundo parto.
EFFECT
0 12 cross alpha # Edad del toro en el segundo parto (< 3 años, >= 3 años, < 4 años >= 4 años, < 5 años).
EFFECT
0 13 cross alpha # Raza del toro (Avileña Negra-Ibérica, Charoles, Limousín).
EFFECT
1 1 cross alpha # Posición del individuo.
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
(CO)VARIANCES
1.0 0.1
0.1 1.0
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
OPTION solution mean
OPTION save_halfway_samples 10000
OPTION no_quality_control
OPTION verify_parentage 3" >> renf90.par

../../../../../BLUPF90/gibbsf90+ <<AA > gibbs.log
renf90.par
200000 50000
50
AA

cd -
