# convert.py
import sys
import scanpy as sc
import anndata2ri
import rpy2.robjects as ro
from rpy2.robjects import pandas2ri

# Input arguments
input_file = sys.argv[1]
output_file = sys.argv[2]

# Activate bridges
anndata2ri.activate()
pandas2ri.activate()

# Load AnnData
adata = sc.read_h5ad(input_file)

# Push into R and save as SingleCellExperiment
ro.globalenv["adata"] = adata
ro.r(f'''
library(SingleCellExperiment)
sce <- adata
saveRDS(sce, file="{output_file}")
''')