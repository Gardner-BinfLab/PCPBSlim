#!/usr/bin/bash
# This script is to run RNAcode

### HEAD ###

# opening message
echo " "
echo "For running of RNAcode"

# Sanity check for location and correct shell
echo " "
sleep 0.1
read -p "Are you running this in the base project folder? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Exiting"
    echo " "
    exit 1
fi
sleep 0.1

# import config settings
source config/main.config.cfg

 
# Process choke. Creates function to allow number of process limits
read -rp "How many processes do you want to spawn at once? " choketime
read -rp "How many cpus per process do you want? " threads

function pwait() {
    while [ "$(jobs -p | wc -l)" -ge "$1" ]; do
        sleep 2
    done
}
sleep 0.1


### BODY ###
 
### set vars ###

# Run list data specific
runDir="data/runs/${experiment}/${runName}"
alignedList="${runDir}/alignedFilesList.txt"
joinedAlignedList="${runDir}/listOfAllAlignments.txt"
shufAlignedList="${runDir}/shufAligns.txt"
rnaCodeList="${runDir}/rnaCodeList.txt"

# Result and other
resultExperimentFolder="results/RNAcode/${experiment}"
resultOutputDir="${resultExperimentFolder}/${runName}"
rnaCompiledResults="${resultExperimentFolder}/RNAcode_${experiment}_${runName}_compiled"

# setup
# create merged list of aligned and shuffled alignments
cat "${alignedList}" "${shufAlignedList}" > "${joinedAlignedList}"
declare -a resultOutputFileList=()

# make directories
mkdir -p "${resultOutputDir}"


### main code run ###

# read list file
readarray -t alignedListArray < "${joinedAlignedList}"

# run RNA code
for alignedFile in "${alignedListArray[@]}"; do 
    filename=$(basename "${alignedFile}")
    output_file="${resultOutputDir}/${filename%.*}_RNAcode"

    RNAcode -s -t "${alignedFile}" -o "${output_file}" &
    resultOutputFileList+=("${output_file}")
    echo "running RNAcode on ${filename}"
    pwait "${choketime}"

done
wait
echo "Finished rna code runs"
echo "Find list of runs here ${rnaCodeList}"
echo " "
echo "now editing results for shuffled alignment names"

# create list of RNA code result files
: > "${rnaCodeList}"
printf "%s\n" "${resultOutputFileList[@]}" >> "${rnaCodeList}" 

wait

# Declare an array to hold the files to be processed
declare -a files_to_process=()

# Rename shuffled alignment RNAcode results data to include "Shuf_"
readarray -t resultList < "${rnaCodeList}"
for file in "${resultList[@]}"; do
  if [[ $(basename "${file}") == "Shuf_"* ]]; then
    awk '{$7 = "Shuf_"$7; print}' "${file}" > "${file}.temp"
    # Add the file to the array
    files_to_process+=("${file}")
  fi
done

# Move temp files to replace original files
for file in "${files_to_process[@]}"; do
  mv "${file}.temp" "${file}"
done
wait

# Top hit compiling
echo " "
echo "Compiling results"
while IFS= read -r file; do
    if [[ -s ${file} ]]; then
        # The file is not empty, print the first line
        awk 'NR == 1 {print; exit}' "${file}"
        else
        # The file is empty, print the default string
        shortFileName=$(basename "${file}" _aligned_RNAcode)
        echo "0 + 0 0 0 0 ${shortFileName} 0 0 0 1"
    fi
done < "${rnaCodeList}" > "${rnaCompiledResults}".txt

# compile results
echo " "
echo "Collating results"
echo "HSS_Number,Strand,Frame,Length,From,To,Name,Start,End,Score,P" > "${rnaCompiledResults}".original
#        1         2       3     4     5   6   7     8     9   10  11 
# convert the whitespace-separated values to comma separated and add to results
awk '{$1=$1}1' OFS=',' "${rnaCompiledResults}".txt >> "${rnaCompiledResults}".original

# Changes order to: Name,Score,Start,End,From,To,Length_nucleotide,Length_aa,Pval
echo "Name,Score,Start,End,Pval" > "${rnaCompiledResults}.csv"
awk '{print $7,$10,$8,$9,$11}' OFS=',' "${rnaCompiledResults}".txt >> "${rnaCompiledResults}.csv"

wait
cp "${rnaCompiledResults}".csv "${compiledResultsFolder}"

echo "Useable results should be available here: ${rnaCompiledResults}.csv"
echo "Finished script"
echo " "
