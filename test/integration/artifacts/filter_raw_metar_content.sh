#!/bin/bash

# Utility script to parse METAR historical data from NOAA: Integrated Surface
# Dataset (Global)

# Usage instruction (automated):
# $ ./filter_raw_metar_content.sh -a ./2021_kjfk.txt

# Usage instructions (manual):
# Filter: $ ./filter_raw_metar_content.sh -f 2021_kjfk.txt > 2021_kjfk_parsed.txt
# Compress: $ bzip2 -k 2021_kjfk_parsed.txt
# Place to final directory: $ mv 2021_kjfk_parsed.txt.bz2 metars/2021_KJFK.bz2
# Cleanup: $ rm 2021_kjfk_parsed.txt 2021_kjfk.txt

function match () {
    keyword=$1
    line=$2
    str=$(echo "$line" | sed -n -e "s/^.*$keyword/$keyword/p" | sed -e 's/([^)]*)//g' | xargs)
    if [ -n "$str" ]
    then
        echo "$str"
    fi
}

function parse_file () {
    filename=$1
    while IFS= read -r line
    do
        match "METAR" "$line"
        match "SPECI" "$line"
    done < "$filename"
}

function prepare_for_check_in () {
    filename=$1
    base_filename="$(basename "$filename")"
    no_extension_filename=${base_filename%.*}
    capital_filename=${no_extension_filename^^}
    final_filename="$(pwd)/metars/$capital_filename.bz2"
    parse_file "$filename" | bzip2 -c > "$final_filename"
    echo "result is written to $final_filename"
}

function print_help () {
  echo "Use '-a {filename}' to prepare file for check-in"
  echo "Use '-f {filename}' to just parse raw data file"
}

while getopts a:f:h flag
do
    case "${flag}" in
        a) prepare_for_check_in "${OPTARG}" ;;
        f) parse_file "${OPTARG}" ;;
        h) print_help ;;
        *) print_help ;;
    esac
done
