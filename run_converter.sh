IMG="docker://mazenkhaddour/scrnaseq:anndata"
INPUT=$1
OUTPUT=$2
if [ -z "$INPUT" ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

singularity exec -B "$(pwd)" -B /group/testa --cleanenv $IMG python /app/convert.py \
     "$INPUT" \
     "$OUTPUT"
