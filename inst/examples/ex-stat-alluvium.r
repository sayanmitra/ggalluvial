# illustrate positioning
ggplot(as.data.frame(Titanic),
       aes(weight = Freq,
           axis1 = Class, axis2 = Sex, axis3 = Age,
           color = Survived)) +
  stat_stratum(geom = "errorbar") +
  geom_line(stat = "alluvium") +
  stat_alluvium(geom = "pointrange") +
  geom_text(stat = "stratum", label.strata = TRUE) +
  scale_x_continuous(breaks = 1:3,
                     labels = c("Class", "Sex", "Age"))

# use of lode controls
ggplot(as.data.frame(Titanic),
       aes(weight = Freq,
           axis1 = Class, axis2 = Sex, axis3 = Age)) +
  geom_flow(aes(fill = Survived), stat = "alluvium",
            aes.bind = TRUE, lode.guidance = "rightward") +
  geom_stratum() + geom_text(stat = "stratum", label.strata = TRUE) +
  scale_x_continuous(breaks = 1:3, labels = c("Class", "Sex", "Age"))

# use of lode ordering
lode_ord <- replicate(n = 3, expr = sample(x = 32), simplify = FALSE)
ggplot(as.data.frame(Titanic),
       aes(weight = Freq,
           axis1 = Class, axis2 = Sex, axis3 = Age)) +
  geom_flow(aes(fill = Survived), stat = "alluvium",
            lode.ordering = lode_ord) +
  geom_stratum() + geom_text(stat = "stratum", label.strata = TRUE) +
  scale_x_continuous(breaks = 1:3, labels = c("Class", "Sex", "Age"))

# omit missing lodes and incident flows
data(majors)
ggplot(majors,
       aes(x = semester, stratum = curriculum, alluvium = student,
           label = curriculum)) +
  geom_alluvium(fill = "darkgrey", na.rm = TRUE) +
  geom_stratum(aes(fill = curriculum), color = NA, na.rm = TRUE) +
  theme_bw()

data(babynames, package = "babynames")
# a discontiguous alluvium
bn <- dplyr::filter(babynames,
                    prop >= .01 & sex == "F" &
                      year > 1962 & year < 1968)
ggplot(data = bn,
       aes(x = year, alluvium = name, weight = prop)) +
  geom_alluvium(aes(fill = name, color = name == "Tammy"),
                decreasing = TRUE, show.legend = FALSE) +
  scale_color_manual(values = c("#00000000", "#000000"))
# filling in missing zeros
bn2 <- merge(bn,
             expand.grid(year = unique(bn$year), name = unique(bn$name)),
             all = TRUE)
bn2$prop[is.na(bn2$prop)] <- 0
ggplot(data = bn2,
       aes(x = year, alluvium = name, weight = prop)) +
  geom_alluvium(aes(fill = name, color = name == "Tammy"),
                decreasing = TRUE, show.legend = FALSE) +
  scale_color_manual(values = c("#00000000", "#000000"))
