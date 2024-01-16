####################################################################################
# Parte 14: script para realizar la imputación con AlphaImpute - imputación conjunta
####################################################################################

# Ruta del archivo de genotipos
genotipos="datGen.txt"

# Ruta del archivo de pedigrí
pedigri="datPed.txt"

# Cambiar al directorio Datos
cd ../Datos/AlphaImpute2

# Opciones de AlphaImpute
Opciones_AlphaImpute="-genotypes $genotipos -pedigree $pedigri -out Resultados/resultado3 -phase_output"

# Comando para ejecutar AlphaImpute
AlphaImpute2 $Opciones_AlphaImpute

# Volver al directorio original
cd -