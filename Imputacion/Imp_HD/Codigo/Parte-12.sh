#!/bin/bash
#######################################################################################
# Parte 12: script para realizar la imputación con AlphaImpute 2 - basado en el pedigrí
#######################################################################################

# Ruta del archivo de genotipos
genotipos="datGen.txt"

# Ruta del archivo de pedigrí
pedigri="datPed.txt"

# Cambiar al directorio Datos
cd ../Datos/AlphaImpute2

# Opciones de AlphaImpute
Opciones_AlphaImpute="-genotypes $genotipos -pedigree $pedigri -out Resultados/resultado1 -ped_only -phase_output -cycles 5"

# Comando para ejecutar AlphaImpute
AlphaImpute2 $Opciones_AlphaImpute

# Volver al directorio original
cd -