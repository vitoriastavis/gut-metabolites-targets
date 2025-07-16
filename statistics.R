load("targets_metabolites.RData")

# Mean number of metabolites per target
cat(mean(sapply(targets_to_metabolites, length)))

# Distribution of metabolites per target
hist(sapply(targets_to_metabolites, length))

# Targets with more metabolites
sort(sapply(targets_to_metabolites, length), decreasing = TRUE)

# Distribution of targets per metabolite
hist(sapply(metabolites_to_targets, length))

# Number of targets per metabolite
ligand_table <- tibble(
  Target = rep(names(targets_to_metabolites), lengths(targets_to_metabolites)),
  Ligand = unlist(targets_to_metabolites)
)
ligand_counts <- ligand_table %>%
  distinct(Target, Ligand) %>%
  count(Ligand, name = "Target_Count") %>%
  arrange(desc(Target_Count))

# Get the metabolites with higher target_count (3)
top_metabolites <- ligand_counts %>%
  filter(Target_Count == 3) %>%
  pull(Ligand)

# Get the targets for those metabolites
top_metabolites_targets <- metabolites_to_targets[top_metabolites]