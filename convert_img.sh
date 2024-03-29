#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 input_file"
    exit 1
fi
echo "Select a compression algorithm:"
echo "1. ZX0"
echo "2. ZX1"
echo "3. LZSA3"
echo "4. Uncompressed"
read -p "Enter the number (1-4): " choice

input_file="$1"
output_file="FINAL_IMG"

case $choice in
    1)
        echo "Using ZX0 compression..."
        zx0 -c "$input_file" "$output_file"
        bin2c "$output_file" img.h img
        rm $output_file
        ;;
    2)
        echo "Using ZX1 compression..."
        zx1 "$input_file" "$output_file"
        bin2c "$output_file" img.h img
        rm $output_file
        ;;
    3)
        echo "Using LZSA3 compression..."
        lzsa3 --prefer-ratio "$input_file" "$output_file"
        bin2c "$output_file" img.h img
        rm $output_file
        ;;
    4)
        echo "Using NO compression..."
        bin2c "$input_file" img.h img
        ;;
    *)
        echo "Invalid selection. Please choose a number between 1 and 3."
        ;;
esac


