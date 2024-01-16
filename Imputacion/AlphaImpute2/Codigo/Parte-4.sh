#!/bin/bash
#####################################################################################
# Parte 4: script para realizar la imputación con AlphaImpute 2 - imputación conjunta
#####################################################################################

# Ruta del archivo de genotipos
genotipos="datGen.txt"

# Ruta del archivo de pedigrí
pedigri="datPed.txt"

# Cambiar al directorio Datos
cd ../Datos

# Opciones de AlphaImpute
Opciones_AlphaImpute="-genotypes $genotipos -pedigree $pedigri -out Resultados/resultado3 -phase_output"

# Comando para ejecutar AlphaImpute
AlphaImpute2 $Opciones_AlphaImpute

# Volver al directorio original
cd -