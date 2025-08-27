"""Convert AnnData files into other single-cell formats."""

import argparse
import scanpy as sc
import anndata2ri
import rpy2.robjects as ro
from rpy2.robjects import pandas2ri


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", help="Input AnnData .h5ad file")
    parser.add_argument("output", help="Output file path")
    parser.add_argument(
        "--format",
        choices=["sce", "loom"],
        default="sce",
        help="Output format",
    )
    parser.add_argument(
        "--use-r",
        action="store_true",
        help="Use an R-based conversion route when supported",
    )
    args = parser.parse_args()

    # Activate bridges
    anndata2ri.activate()
    pandas2ri.activate()

    # Load AnnData
    adata = sc.read_h5ad(args.input)

    if args.format == "sce":
        ro.globalenv["adata"] = adata
        ro.r(
            f"""
            library(SingleCellExperiment)
            sce <- adata
            saveRDS(sce, file="{args.output}")
            """
        )
    elif args.format == "loom":
        if args.use_r:
            ro.globalenv["adata"] = adata
            ro.r(
                f"""
                library(Seurat)
                seu <- as.Seurat(adata)
                library(SeuratDisk)
                as.loom(seu, filename="{args.output}")
                """
            )
        else:
            adata.write_loom(args.output)
    else:
        raise ValueError(f"Unsupported format: {args.format}")


if __name__ == "__main__":
    main()