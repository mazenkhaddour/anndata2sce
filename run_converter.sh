IMG="docker://mazenkhaddour/scrnaseq:anndata"
FORMAT="sce"
USE_R=""

while [[ "$1" == --* ]]; do
    case "$1" in
        --format)
            FORMAT="$2"
            shift 2
            ;;
        --use-r)
            USE_R="--use-r"
            shift
            ;;
        *)
            echo "Unknown option: $1" >&2
            exit 1
            ;;
    esac
done

INPUT=$1
OUTPUT=$2
if [ -z "$INPUT" ] || [ -z "$OUTPUT" ]; then
    echo "Usage: $0 [--format FORMAT] [--use-r] <input_file> <output_file>" >&2
    exit 1
fi

singularity exec -B "$(pwd)" -B /group/testa --cleanenv $IMG python /app/convert.py \
     "$INPUT" \
     "$OUTPUT" \
     --format "$FORMAT" \
     $USE_R
