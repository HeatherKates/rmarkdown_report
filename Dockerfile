FROM rocker/r-ver:4.3.2

# Install base packages from CRAN (except downloadthis)
RUN install2.r --error \
    AnnotationDbi \
    base64enc \
    Biobase \
    car \
    clusterProfiler \
    data.table \
    dplyr \
    DT \
    edgeR \
    ggfortify \
    ggplot2 \
    ggrepel \
    grid \
    gridExtra \
    gtable \
    heatmaply \
    Homo.sapiens \
    htmltools \
    hues \
    jsonlite \
    kableExtra \
    knitr \
    limma \
    NOISeq \
    openxlsx \
    optparse \
    org.Hs.eg.db \
    org.Mm.eg.db \
    pheatmap \
    plotly \
    png \
    qs \
    RColorBrewer \
    readr \
    rmarkdown \
    stringr \
    tibble \
    tidyr \
    tidyverse \
    yaml

# Add Bioconductor packages (some may be redundant, but this is safe)
RUN R -e "install.packages('BiocManager', repos='https://cloud.r-project.org'); \
          BiocManager::install(c('AnnotationDbi', 'Biobase', 'clusterProfiler', \
          'Homo.sapiens', 'NOISeq', 'org.Hs.eg.db', 'org.Mm.eg.db'))"

# Create R site-library directory
RUN mkdir -p /usr/local/lib/R/site-library

# Copy your manually installed downloadthis package into the image
COPY downloadthis /usr/local/lib/R/site-library/downloadthis

# Ensure R sees that location as part of its library path
ENV R_LIBS_SITE=/usr/local/lib/R/site-library

