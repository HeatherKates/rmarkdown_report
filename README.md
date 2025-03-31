# Docker to Singularity (.sif) Workflow

This guide explains how to:

1. Build a Docker image from a `Dockerfile`
2. Export and compress it to a `.tar.gz` file
3. Transfer the archive to a remote server
4. Convert it into a `.sif` file for use with Apptainer/Singularity

---

## 1. Build the Docker Image

Make sure you're in the project directory that contains your `Dockerfile`.

```bash
docker build -f Dockerfile -t rmarkdown_report .
```
This creates a Docker image named rmarkdown_report.

## 2. Save and Compress the Docker Image
Export the Docker image to a .tar.gz file:

```docker save rmarkdown_report | gzip > rmarkdown_report.tar.gz```

## 3. Transfer to Remote Server via SCP
Replace user@remote:/path/to/destination with your actual remote server info:

```scp rmarkdown_report.tar.gz user@remote:/path/to/destination```

## 4. Load and Convert to .sif on Remote Server
SSH into the remote server:

```ssh user@remote```

Then:

a. Decompress the Docker image from the archive

```gunzip -c rmarkdown_report.tar.gz > rmarkdown_report.tar```

b. Convert to Singularity (.sif) using Apptainer

```apptainer build my_rmarkdown_report.sif docker-archive://rmarkdown_report.tar```

## Done!
You now have a .sif container ready to use with Singularity or Apptainer.
