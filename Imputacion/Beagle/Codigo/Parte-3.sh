#!/bin/bash
##############################################################
# Parte 3: script para realizar la imputación con Beagle V 5.4
##############################################################

# Ruta del archivo VCF
gt="Paso_2.vcf"

# Ruta de salida del archivo imputado
output="Res_imputacion_v5.4"

# Cambiar al directorio Datos
cd ../Datos

# Ruta del archivo Beagle JAR
beagle_jar="../beagle_v5.4.jar"

# Opciones de Beagle
beagle_options="gt=$gt out=$output" # Si gp=true, se indica que se incluira un campo de formato GP (probablidad de genotipo) en el archivo VCF. Esto si se considera también un panel de referencia.

# Comando para ejecutar Beagle
java -Xmx4g -jar $beagle_jar $beagle_options

# Volver al directorio original
cd -
