FROM rocker/rstudio:4.3.2

# Install core system packages
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    pandoc \
    libhdf5-dev \
    libpng-dev \
    libfontconfig1-dev \
    git \
    wget

# Install CRAN packages
RUN install2.r --error \
    base64enc \
    car \
    data.table \
    dplyr \
    DT \
    ggfortify \
    ggplot2 \
    ggrepel \
    gridExtra \
    gtable \
    heatmaply \
    htmltools \
    hues \
    jsonlite \
    kableExtra \
    knitr \
    openxlsx \
    optparse \
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

# Install Bioconductor packages
RUN install2.r --error --repos https://bioconductor.org/packages/3.17/bioc \
    AnnotationDbi \
    Biobase \
    clusterProfiler \
    edgeR \
    limma \
    Homo.sapiens \
    NOISeq \
    org.Hs.eg.db \
    org.Mm.eg.db

# Create R site-library directory
RUN mkdir -p /usr/local/lib/R/site-library

# Copy your manually installed downloadthis package into the image
COPY downloadthis /usr/local/lib/R/site-library/downloadthis

# Ensure R sees that location as part of its library path
ENV R_LIBS_SITE=/usr/local/lib/R/site-library

