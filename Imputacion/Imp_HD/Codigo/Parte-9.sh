#!/bin/bash
################################################################
# Parte 9: evaluación de la precisión de la imputación - Parte 2
################################################################

# Ruta del archivo VCF
gt="Grup4.vcf" # Aquí, tuve que cambiar de acuerdo al archivo VCF que quise imputar (Grup1.vcf, Grup2.vcf, ..., Grup4.vcf).

# Ruta de salida del archivo imputado
output="Res_imputacion_v5.4"

# Cambiar al directorio Prec_*
cd ../Datos/Beagle/Precision_origen/Prec_4 # Aquí tuve que cambiar al directorio del respectivo archivo VCF (Prec_1, Prec_2, ..., Prec_4).

# Ruta del archivo Beagle JAR
beagle_jar="../../../../../Beagle/beagle_v5.4.jar"

# Opciones de Beagle
beagle_options="gt=$gt gp=true out=$output" # Esta opción ("gp") indica que se incluira un campo de formato GP (probablidad de genotipo) en el archivo VCF.

# Comando para ejecutar Beagle
java -Xmx4g -jar $beagle_jar $beagle_options

# Volver al directorio original
cd -