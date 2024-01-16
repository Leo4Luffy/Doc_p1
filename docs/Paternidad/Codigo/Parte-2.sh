#!/bin/bash
#######################################################
# Parte 2: script para correr el programa SeekParentF90
#######################################################

# Nombre del archivo de pedigrí
pedigri="datPed.txt"

# Nombre del archivo de marcadores
marcadores="datMar.txt"

# Lista de toros
toros="datPad.txt"

# Lista de vacas
vacas="datMad.txt"

# Cambiar al directorio Datos
cd ../Datos

# Correr el programa SeekParentF90 con el umbral por defecto (1%)
../seekparentf90 --pedfile $pedigri --snpfile $marcadores --seeksire $toros --seekdam $vacas --excl_thr_prob 1 # Si se quisiera cambiar el umbral (aquí mostrado por 1%), se cambiaria, por ejemplo, con 3% y 5%.

# NOTA: No hubo problemas de paternidad ya que al revisar el archivo generado "Check_datPed.txt", no hubo casos de No-Match.

# Volver al directorio original
cd -
