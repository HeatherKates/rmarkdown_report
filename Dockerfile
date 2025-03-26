FROM bioconductor/bioconductor_docker:RELEASE_3_17

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
    wget \
    && apt-get clean

# Install CRAN packages via install2.r
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

# Install Bioconductor packages with dependencies
RUN Rscript -e "if (!requireNamespace('BiocManager', quietly=TRUE)) \
    install.packages('BiocManager', repos='https://cloud.r-project.org'); \
    BiocManager::install(c( \
      'AnnotationDbi', 'Biobase', 'clusterProfiler', 'edgeR', 'limma', \
      'Homo.sapiens', 'NOISeq', 'org.Hs.eg.db', 'org.Mm.eg.db'), \
      ask = FALSE, update = FALSE)"

# Create R site-library path (if not already present)
RUN mkdir -p /usr/local/lib/R/site-library

# Copy manually installed 'downloadthis' package into the image
COPY downloadthis /usr/local/lib/R/site-library/downloadthis

# Ensure R recognizes the site-library path
ENV R_LIBS_SITE=/usr/local/lib/R/site-library
