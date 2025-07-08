# anndata2ri
Bash script for converting anndata to single cell experiment

# Prequistics: 
- singularity

# Install:
for reprducibility, I indluded the Docker file that use to build the image.
copy the bash file into your working directory and make it excutable 
```
chmod +x run_converter.sh
```
in order to launch the script you need to provide the input (H5AD file) as the first argument, and the output (rds file ) as the second argument. \

**code example**
```
./run_converter.sh h5ad_input_path rds_output_file
```
till now **08.07.2025** no exception handling is provided. 

