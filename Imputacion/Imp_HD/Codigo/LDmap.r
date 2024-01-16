#!/usr/bin/Rscript

# Con el encabezado anterior, llamado "shebang", se indica que el intérprete a utilizar es R.

#######
# LDmap
#######

pacman::p_load(tidyverse)

# Con los archivos PLINK generados, se visualiza los bloques de desequilibrio de ligamiento mediante un Heatmap de Desequilibrio de Ligamiento (R^2) ----

ldMar <- read_table(file = '../Datos/Beagle/Precision_imputados/Paso_5.ld', col_names = TRUE) # Se importa el archivo "Paso_5.ld" donde se encuentran los valores R2.

# Se itera sobre los cromosomas y se construye los gráficos y se guardan
for (cromo in 1:29) {
  ldMar_cromo <- ldMar %>%
    filter(CHR_A == cromo, SNP_A != SNP_B)

  mR2 <- ldMar_cromo %>%
    reshape2::dcast(SNP_A ~ SNP_B, value.var = 'R2', fun.aggregate = sum)

  dfR2 <- reshape2::melt(mR2, id.vars = 'SNP_A')

  plot_title <- paste('Cromosoma', cromo)

  cromo_plot <- ggplot(dfR2, aes(x = SNP_A, y = variable, fill = value)) +
    geom_tile() +
    scale_fill_gradient(low = 'white', high = 'green', name = 'r²') +
    labs(title = plot_title, x = ' ', y = ' ') +
    theme_bw() +
    theme(
      plot.title = element_text(size = 8, face = 'bold'),
      axis.text = element_blank(),
      axis.ticks = element_blank()
    )

  # Generar el nombre del archivo de imagen
  nombre_imagen <- paste('../Imagenes/Cromosoma', cromo, '.png', sep = '')

  # Guardar la figura como una imagen PNG
  ggsave(filename = nombre_imagen, plot = cromo_plot, width = 6, height = 6)
  }
