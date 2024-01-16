#!/bin/bash
#######################################################################################
# Parte 13: script para realizar la imputación con AlphaImpute - basado en la población
#######################################################################################

# Ruta del archivo de genotipos
genotipos="datGen.txt"

# Ruta del archivo de pedigrí
pedigri="datPed.txt"

# Cambiar al directorio Datos
cd ../Datos/AlphaImpute2

# Opciones de AlphaImpute
Opciones_AlphaImpute="-genotypes $genotipos -pedigree $pedigri -out Resultados/resultado2 -pop_only -phase_output -n_phasing_cycles 5"

# Comando para ejecutar AlphaImpute
AlphaImpute2 $Opciones_AlphaImpute

# Volver al directorio original
cd -