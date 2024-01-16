#!/bin/bash
################################################################
# Parte 5: evaluación de la precisión de la imputación - Parte 2
################################################################

# Ruta del archivo VCF
gt="Grup8.vcf" # Aquí, tuve que cambiar de acuerdo al archivo VCF que quise imputar (Grup1.vcf, Grup2.vcf, ..., Grup8.vcf).

# Ruta del archivo de pedigrí
ped="datPed.txt"

# Ruta de salida del archivo imputado
output="Res_imputacion_v4.0"

# Cambiar al directorio Prec_*
cd ../Datos/Precision/Prec_8 # Aquí tuve que cambiar al directorio del respectivo archivo VCF (Prec_1, Prec_2, ..., Prec_8).

# Ruta del archivo Beagle JAR
beagle_jar="../../../beagle_v4.0.jar"

# Opciones de Beagle
beagle_options="gt=$gt ped=$ped out=$output" # Por defector gprobs=true, lo que indica que se incluirá un campo de formato GP (probabilidad de genotipo) en el archivo VCF de salida.

# Comando para ejecutar Beagle
java -Xmx4g -jar $beagle_jar $beagle_options

# Volver al directorio original
cd -
