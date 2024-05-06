# Load required libraries
#install.packages("devtools")
#devtools::install_github("G-Thomson/Manu")
#library(devtools)
library(ggplot2)
library(Manu)  # Assuming this library is available for the color palettes


# Read data from the table
incl <- read.table(file="data/inclusion.txt", header=TRUE, sep="\t")

# Define the color palette
pal <- c(get_pal("Kea"), get_pal("Takahe")[1])

# Pie Chart
pdf(file='pie.pdf', width=10, height=10)
ggplot(incl, aes(x="", y=Cnt, fill=factor(Criteria))) +
  geom_bar(stat="identity", width=1) +
  coord_polar(theta="y") +
  labs(title="Include/Excluded Tools", fill="Criteria") +
  theme_void() +
  scale_fill_manual(values=pal)


# Bar Plot
pdf(file='barplot-excluded.pdf', width=12, height=10)

incl$Criteria <- factor(incl$Criteria, levels = rev(c("included", sort(setdiff(unique(incl$Criteria), "included")))))
# Create the bar plot

ggplot(incl, aes(x=Criteria, y=Cnt, fill=Criteria)) +
  geom_bar(stat="identity", position="dodge") +
  coord_flip() +
  labs(title="Number of included tools & exclusion reasons", x="", y="") +
  scale_fill_manual(values=pal) +
  scale_y_continuous(breaks = seq(floor(min(incl$Cnt)), 12, by = 1), expand = expansion(mult = c(0.0, 0.1))) +
  geom_text(aes(label=paste(round(100 * Cnt / 36), "%", sep="")), position=position_dodge(width=0.9), hjust=-0.1) +
  theme_minimal() +
  theme(axis.text.x = element_text(hjust=1, size=14),
        axis.text.y = element_text(size=16),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        plot.title = element_text(size=20),
        legend.position = "none")


