#!/bin/bash
##############################################################
# Parte 2: script para realizar la imputación con Beagle V 4.0
##############################################################

# Ruta del archivo VCF
gt="Paso_5.vcf"

# Ruta del archivo de pedigrí
ped="datPed.txt"

# Ruta de salida del archivo imputado
output="Res_imputacion_v4.0"

# Cambiar al directorio Datos
cd ../Datos

# Ruta del archivo Beagle JAR
beagle_jar="../beagle_v4.0.jar"

# Opciones de Beagle
beagle_options="gt=$gt ped=$ped out=$output" # Por defecto gprobs=true, lo que indica que se incluirá un campo de formato GP (probabilidad de genotipo) en el archivo VCF de salida.

# Comando para ejecutar Beagle
java -Xmx4g -jar $beagle_jar $beagle_options

# Volver al directorio original
cd -
