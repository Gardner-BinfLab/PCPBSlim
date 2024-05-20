# Protein Coding Potential Benchmark Results

This repository has been created for the purpose of sharing the final results, controls, and relevant software pipline for the research paper: <insert link>

The research paper pertians to benchmarking of protein coding potential tools.

While it's possible to run the scripts in this repository, it's not recommended without further setup. If you want to run the pipeline to verify the results in the research paper, you will need to follow the instructions in the repository here <insert verificationPipelineRepository> which contains all the necessary information and data to reproduce the results.

If you want to run your own protein coding potential calculator benchmarks using the pipeline, see here for an updated and useable standalone version <insert standaloneRepository>


# Simple Access Instructions

To access the project and results, create a local project directory. For example:
```
mkdir PCBResults
```

Now clone the repository to the project directory.
```
git clone https://github.com/Gardner-BinfLab/PCPBResults PCPBResults
```

This will download the benchmarking pipline and curated paper data and results.
Run the setup.sh script which will decompress the results and controls.
```
cd PCBResults
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
```
/scripts/main
```
- Bash scripts that were used for setting up and running the benchmarks.
```
scripts/R
```
- R project files that were used for result interpretiation.
```
scripts/support
```
- Collection of various helper scripts used.
