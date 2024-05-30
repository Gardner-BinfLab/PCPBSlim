# Protein Coding Potential Benchmark Results

This repository has been created for the purpose of sharing the tool prediction scores, control sequences and alignment for the research paper: https://doi.org/10.1101/2024.05.16.594598

The research paper 'Flawed machine-learning confounds coding sequence annotation' pertians to benchmarking of protein coding potential tools.

If you want to run the pipeline to verify the results in the research paper, you will need to follow the instructions in the repository here https://github.com/Gardner-BinfLab/PCPBFull which contains all the necessary scripts, information and data to reproduce the results.

If you want to run your own protein coding potential calculator benchmarks using the pipeline, see here for an updated and useable standalone version:(not yet available)


# Simple Access Instructions

To access the project and results, create a local project directory. For example:
```
mkdir PCPBSlim
```

Now clone the repository to the project directory.
```
git clone https://github.com/Gardner-BinfLab/PCPBSlim PCPBSlim
```

This will download the curated paper data and results.
Run the setup.sh script which will decompress the results and controls.
```
cd PCPBSlim
./setup.sh
```

You will now have access to the results files.


# File and folder guide
```
/results
```
- all_scores.csv - Every score from each tool.
- Compiled results output from software tools run in the pipeline.
```
/data/controls
```
- Positive and negative alignments and sequences used for benchmarking.
```
/data/controls/sequences/clade/type
```
- Sequences separated into each clade (animalia, fungi, plantae) separated into each type (coding, intergenic, shuffled)
```
/data/controls/alignments/clade/type
```
- Alignments separated into each clade (animalia, fungi, plantae) separated into each type (coding, intergenic, shuffled)