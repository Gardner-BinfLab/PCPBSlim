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

/compiledResults
- Compiled results output from software tools run in the pipeline

/controls
- Positive and negative alignments and sequences used for benchmarking

/scripts
    /main
    - Bash scripts for setting up and running the benchmarks.
    - Generally run in order from A00 to D00
    - Special cases are Txx for timing of tools

    /R
    - R project files that were used for result interpretiation

    /support
    - Collection of various helper scripts
