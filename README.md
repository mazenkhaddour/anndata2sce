# anndata2sce
Bash script for converting anndata to single cell experiment.

# Prequistics:
- singularity

# Install:
For reproducibility, a Dockerfile is provided. Copy the bash file into your working
directory and make it executable:
```
chmod +x run_converter.sh
```
The script requires an input `.h5ad` file and an output file path. By default the
output is a `SingleCellExperiment` RDS file, but other formats can be selected via
`--format`.

**Code example**
```
# SingleCellExperiment output
./run_converter.sh h5ad_input_path sce_output.rds

# Loom output using the Python writer
./run_converter.sh --format loom h5ad_input_path output.loom

# Loom output through R/Seurat (requires SeuratDisk)
./run_converter.sh --format loom h5ad_input_path output.loom --use-r
```

Loom support relies on either the `loompy` Python package or the R packages
`Seurat` and `SeuratDisk` (installed via the Dockerfile). Ensure these dependencies
are available when running outside the provided container.

Till now **08.07.2025** no exception handling is provided.
