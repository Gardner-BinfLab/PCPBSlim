software_names <- c("stopFree", "CPC2", "LGC", "CPPred", "tcode", "RNAsamba", "bioseq2seq", "PLEK")
clade_names <- "sixFrame"



wide_sixFrame_list <- list()
###
for(software in software_names){
  # Transform the data
  results_wide <- combined_tool_results_list[[software]][["sixFrame"]] %>%
    select(Name, Score) %>% 
    # Separate the Name column into multiple parts
    separate(Name, into = c("Part1", "Part2", "Part3", "Part4", "Part5", "Part6", "Mod1", "Mod2"), sep = "_", fill = "right", extra = "merge") %>%
    # Combine the first two parts back into a single 'Name' column
    unite("Sequence", Part1, Part2, Part3, Part4, Part5, Part6, sep = "_", remove = TRUE) %>%
    unite("Modification", Mod1, Mod2, sep = "_", remove = TRUE, na.rm = TRUE) %>% 
    # Spread the scores into wide format
    spread(key = Modification, value = Score) %>%
    mutate(minus1Diff = (original - minus1) / original ) %>% 
    mutate(minus2Diff = (original - minus2) / original ) %>%
    mutate(revCompDiff = (original - revComp) / original ) %>% 
    mutate(revCompMinus1Diff = (original - revComp_minus1) / original ) %>% 
    mutate(revCompMinus2Diff = (original - revComp_minus2) / original ) %>% 
    select(Sequence, minus1Diff, minus2Diff, revCompDiff, revCompMinus1Diff, revCompMinus2Diff, original, minus1, minus2, revComp, revComp_minus1, revComp_minus2)

  
  # Keep data
  wide_sixFrame_list[[software]] <- results_wide
  write.csv(results_wide, paste("../../results/misc/", software, "_sixFrame_result.csv"))
}

