Programming assignment 4
================

**Author**: Alejandro Jaume-Losa **Date**: Last update: 2024-04-12
17:46:09.814569

# Overview

## What did I do?

In order to complete this last programming assignment, I first forked
the repo and cloned it to my computer using Github Desktop. Then, I took
a look at its structure and the README files in each folder. Once I had
a “clear” idea of what I had to (+/-), I proceed to run the first Praat
script. This script was intended to normalize the peak intensity of all
of the files in the ‘wavs’ folders. This script was not broken and I did
not have to add anyting else either, so I just ran it. Once I was done
doing that, I proceeded to run the second script, which was intended to
read in every .wav file from the ‘wavs’ folders and create a
corresponding TextGrid with the same name. This script had some missing
information, so I had to add the participant ID (i.e., bi02) and also
replace “XXXX” with “45” (i.e., the total number of recordings per
participant). Once that was done, I proceeded to segment all the file
using the TextGrids created by the second Praat script (this took a
while). Finally, once I was done doing that, I proceeded to run the
third and last Praat script, which was intended to extract the VOT, F1,
and F2 values from each file and create a .csv file for each
participant. Once I had all the .csv files, I opened R and loaded the
necessary packages. Then, I loaded the six .csv files and combined them.
After that, I tidyed the data, I did some descriptive stats, and created
some plots.

## Hypothesis

For this programming assignment, we are working with data from 3
bilingual speakers (Spanish-English), and 3 L2 learners (native speakers
of English). Based on this, we can assume that their production of the
target words will be different. For instance, in terms of VOT, Spanish
and English are different: Spanish has short and lead lag, while English
has short, long, and lead lag). This can be summarized by saying that
the VOT for Spanish stops is shorter compared to the longer VOT that
English stops have. Therefore, my hypothesis is that the L2 learners
will have longer VOTs, due to influence of English.

# Prep

## Libraries

## Load data

``` r
# You need to get all the files in the 'data' directory and combine them
# Check previous examples we did in class

read_csv(file = "../data/bi01.csv")
```

    ## Rows: 45 Columns: 5
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (2): fileID, notes
    ## dbl (3): f1, f2, vot
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    ## # A tibble: 45 × 5
    ##    fileID        f1    f2   vot notes
    ##    <chr>      <dbl> <dbl> <dbl> <chr>
    ##  1 bi01_kaka   651. 1637.  24.8 <NA> 
    ##  2 bi01_kaka1  714. 1568.  25.5 <NA> 
    ##  3 bi01_kaka2  709. 1560.  28.3 <NA> 
    ##  4 bi01_keke   495. 2168.  31.6 <NA> 
    ##  5 bi01_keke1  893. 2153.  32.4 <NA> 
    ##  6 bi01_keke2  579. 2339.  32.9 <NA> 
    ##  7 bi01_kiki   824. 2712.  18.5 <NA> 
    ##  8 bi01_kiki1  348. 2632.  52.8 <NA> 
    ##  9 bi01_kiki2  494. 2766.  50.5 <NA> 
    ## 10 bi01_koko   499. 1050.  30.9 <NA> 
    ## # ℹ 35 more rows

``` r
read_csv(file = "../data/bi02.csv")
```

    ## Rows: 45 Columns: 5
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (1): fileID
    ## dbl (3): f1, f2, vot
    ## lgl (1): notes
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    ## # A tibble: 45 × 5
    ##    fileID        f1    f2   vot notes
    ##    <chr>      <dbl> <dbl> <dbl> <lgl>
    ##  1 bi02_kaka   780. 1573.  22.7 NA   
    ##  2 bi02_kaka1  795. 1549.  24.6 NA   
    ##  3 bi02_kaka2  553. 1506.  24.6 NA   
    ##  4 bi02_keke   468. 2213.  22.3 NA   
    ##  5 bi02_keke1  462. 2349.  19.4 NA   
    ##  6 bi02_keke2  540. 2308.  20.8 NA   
    ##  7 bi02_kiki   335. 2630.  35.0 NA   
    ##  8 bi02_kiki1  348. 2688.  18.9 NA   
    ##  9 bi02_kiki2  339. 2660.  28.9 NA   
    ## 10 bi02_koko   616.  988.  31.1 NA   
    ## # ℹ 35 more rows

``` r
read_csv(file = "../data/bi03.csv")
```

    ## Rows: 45 Columns: 5
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (1): fileID
    ## dbl (3): f1, f2, vot
    ## lgl (1): notes
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    ## # A tibble: 45 × 5
    ##    fileID        f1    f2   vot notes
    ##    <chr>      <dbl> <dbl> <dbl> <lgl>
    ##  1 bi03_kaka  1081. 1898.  17.7 NA   
    ##  2 bi03_kaka1  836. 1495.  29.2 NA   
    ##  3 bi03_kaka2  831. 1654.  24.0 NA   
    ##  4 bi03_keke   829. 2389.  21.2 NA   
    ##  5 bi03_keke1  526. 2279.  22.2 NA   
    ##  6 bi03_keke2  501. 2509.  19.8 NA   
    ##  7 bi03_kiki   402. 2667.  34.5 NA   
    ##  8 bi03_kiki1  350. 2707.  22.2 NA   
    ##  9 bi03_kiki2  348. 2678.  24.9 NA   
    ## 10 bi03_koko   554.  836.  24.8 NA   
    ## # ℹ 35 more rows

``` r
read_csv(file = "../data/ne01.csv")
```

    ## Rows: 45 Columns: 5
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (1): fileID
    ## dbl (3): f1, f2, vot
    ## lgl (1): notes
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    ## # A tibble: 45 × 5
    ##    fileID        f1    f2   vot notes
    ##    <chr>      <dbl> <dbl> <dbl> <lgl>
    ##  1 ne01_kaka   862. 1650.  8.45 NA   
    ##  2 ne01_kaka1  948. 1776. 23.6  NA   
    ##  3 ne01_kaka2 1062. 1779. 29.2  NA   
    ##  4 ne01_keke   471. 2487. 38.7  NA   
    ##  5 ne01_keke1  604  2466. 28.6  NA   
    ##  6 ne01_keke2  491. 2654. 25.4  NA   
    ##  7 ne01_kiki   343. 2845. 42.7  NA   
    ##  8 ne01_kiki1  965. 2272. 53.3  NA   
    ##  9 ne01_kiki2  439. 2781. 44.6  NA   
    ## 10 ne01_koko   666. 1083. 49.0  NA   
    ## # ℹ 35 more rows

``` r
read_csv(file = "../data/ne02.csv")
```

    ## Rows: 45 Columns: 5
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (1): fileID
    ## dbl (3): f1, f2, vot
    ## lgl (1): notes
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    ## # A tibble: 45 × 5
    ##    fileID        f1    f2   vot notes
    ##    <chr>      <dbl> <dbl> <dbl> <lgl>
    ##  1 ne02_kaka  565.  1412.  39.8 NA   
    ##  2 ne02_kaka1 947.  2253.  52.7 NA   
    ##  3 ne02_kaka2  70.3 1504.  54.2 NA   
    ##  4 ne02_keke  469.  2409.  34.6 NA   
    ##  5 ne02_keke1 421.  2484.  45.1 NA   
    ##  6 ne02_keke2 496.  2239.  29.7 NA   
    ##  7 ne02_kiki  357.  2693.  61.8 NA   
    ##  8 ne02_kiki1 344.  2778.  82.7 NA   
    ##  9 ne02_kiki2 324.  2771.  57.6 NA   
    ## 10 ne02_koko  555.  1042.  44.3 NA   
    ## # ℹ 35 more rows

``` r
read_csv(file = "../data/ne03.csv")
```

    ## Rows: 45 Columns: 5
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (1): fileID
    ## dbl (3): f1, f2, vot
    ## lgl (1): notes
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

    ## # A tibble: 45 × 5
    ##    fileID        f1    f2   vot notes
    ##    <chr>      <dbl> <dbl> <dbl> <lgl>
    ##  1 ne03_kaka   768. 1804.  27.1 NA   
    ##  2 ne03_kaka1  819. 1725.  26.3 NA   
    ##  3 ne03_kaka2  881. 1548.  38.4 NA   
    ##  4 ne03_keke   656. 2639.  31.0 NA   
    ##  5 ne03_keke1  568. 1766.  32.0 NA   
    ##  6 ne03_keke2  562. 2564.  35.6 NA   
    ##  7 ne03_kiki   507. 2713.  37.3 NA   
    ##  8 ne03_kiki1  408. 2070.  75.6 NA   
    ##  9 ne03_kiki2  373. 2805.  61.0 NA   
    ## 10 ne03_koko   509. 1071.  45.9 NA   
    ## # ℹ 35 more rows

``` r
bi01 <- read_csv(here("data", "bi01.csv"))
```

    ## Rows: 45 Columns: 5
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (2): fileID, notes
    ## dbl (3): f1, f2, vot
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
bi02 <- read_csv(here("data", "bi02.csv"))
```

    ## Rows: 45 Columns: 5
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (1): fileID
    ## dbl (3): f1, f2, vot
    ## lgl (1): notes
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
bi03 <- read_csv(here("data", "bi03.csv"))
```

    ## Rows: 45 Columns: 5
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (1): fileID
    ## dbl (3): f1, f2, vot
    ## lgl (1): notes
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
ne01 <- read_csv(here("data", "ne01.csv"))
```

    ## Rows: 45 Columns: 5
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (1): fileID
    ## dbl (3): f1, f2, vot
    ## lgl (1): notes
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
ne02 <- read_csv(here("data", "ne02.csv"))
```

    ## Rows: 45 Columns: 5
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (1): fileID
    ## dbl (3): f1, f2, vot
    ## lgl (1): notes
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
ne03 <- read_csv(here("data", "ne03.csv"))
```

    ## Rows: 45 Columns: 5
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (1): fileID
    ## dbl (3): f1, f2, vot
    ## lgl (1): notes
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
data <- rbind(bi01,bi02,bi03, ne01,ne02, ne03)

bi <- rbind(bi01,bi02,bi03)
ne <- rbind(ne01,ne02, ne03)
```

## Tidy data

``` r
# Convert from long to wide or wide to long format as necessary (check 
# examples from class)
# Create any other relevant variables here 

# Tidying data

data_tidy <- data %>%
  separate(fileID, into = c("id","stim"), sep = 4) %>%
  mutate(word = str_remove(stim, "[_]")) %>%
  mutate(item = str_remove(word, "[1-2]")) %>%
  mutate(group = case_when(
    startsWith(id, "bi") ~ "bi",
    startsWith(id, "ne") ~ "ne"
  ))

bi_tidy <- bi %>%
  separate(fileID, into = c("id","stim"), sep = 4)%>%
  mutate(word = str_remove(stim,"[_]"))%>%
  mutate(item = str_remove(word, "[1-2]"))

ne_tidy <- ne %>%
  separate(fileID, into = c("id","stim"), sep = 4)%>%
  mutate(word = str_remove(stim,"[_]"))%>%
  mutate(item = str_remove(word, "[1-2]"))

# Getting final data sets

data_final <- select(data_tidy, id, group, item, vot, f1, f2)

bi_final <- select(bi_tidy, id, item, vot, f1, f2)

ne_final <- select(ne_tidy, id, item, vot, f1, f2)
```

# Analysis

## Descriptives

``` r
# Give some descriptive summaries of your data 
# Display your descriptives in a table (try knitr::kable())

means <- data_final %>%
  group_by(id) %>%
  summarise(vot_mean = mean(vot), vot_sd = sd(vot), f1_mean = mean(f1), f1_sd = sd(f1), f2_mean = mean(f2), f2_sd = sd(f2))

kable(means)
```

| id   | vot_mean |    vot_sd |  f1_mean |    f1_sd |  f2_mean |    f2_sd |
|:-----|---------:|----------:|---------:|---------:|---------:|---------:|
| bi01 | 26.19733 | 23.572779 | 520.2511 | 138.3988 | 1727.237 | 666.6207 |
| bi02 | 17.86356 |  7.542213 | 525.0113 | 132.9608 | 1588.668 | 677.9067 |
| bi03 | 17.17222 |  7.357463 | 612.5673 | 239.1793 | 1711.122 | 699.1391 |
| ne01 | 28.20733 | 16.370086 | 608.5418 | 235.1716 | 1868.547 | 728.0210 |
| ne02 | 31.63333 | 16.845453 | 541.8582 | 212.1680 | 1833.359 | 658.8014 |
| ne03 | 34.90911 | 16.299097 | 569.7533 | 143.6087 | 1641.323 | 570.6210 |

``` r
means_group <- data_final %>%
  group_by(group) %>%
  summarise(vot_mean = mean(vot), vot_sd = sd(vot), f1_mean = mean(f1), f1_sd = sd(f1), f2_mean = mean(f2), f2_sd = sd(f2))

kable(means_group)
```

| group | vot_mean |   vot_sd |  f1_mean |    f1_sd |  f2_mean |    f2_sd |
|:------|---------:|---------:|---------:|---------:|---------:|---------:|
| bi    | 20.41104 | 15.35773 | 552.6099 | 180.8129 | 1675.675 | 679.0975 |
| ne    | 31.58326 | 16.61162 | 573.3844 | 201.1625 | 1781.076 | 658.4155 |

``` r
bi_means <- bi_final %>%
  group_by(id) %>%
  summarise(vot_mean = mean(vot), vot_sd = sd(vot), f1_mean = mean(f1), f1_sd = sd(f1), f2_mean = mean(f2), f2_sd = sd(f2))

kable(bi_means)
```

| id   | vot_mean |    vot_sd |  f1_mean |    f1_sd |  f2_mean |    f2_sd |
|:-----|---------:|----------:|---------:|---------:|---------:|---------:|
| bi01 | 26.19733 | 23.572779 | 520.2511 | 138.3988 | 1727.237 | 666.6207 |
| bi02 | 17.86356 |  7.542213 | 525.0113 | 132.9608 | 1588.668 | 677.9067 |
| bi03 | 17.17222 |  7.357463 | 612.5673 | 239.1793 | 1711.122 | 699.1391 |

``` r
ne_means <- ne_final %>%
  group_by(id) %>%
  summarise(vot_mean = mean(vot), vot_sd = sd(vot), f1_mean = mean(f1), f1_sd = sd(f1), f2_mean = mean(f2), f2_sd = sd(f2))

kable(ne_means)
```

| id   | vot_mean |   vot_sd |  f1_mean |    f1_sd |  f2_mean |    f2_sd |
|:-----|---------:|---------:|---------:|---------:|---------:|---------:|
| ne01 | 28.20733 | 16.37009 | 608.5418 | 235.1716 | 1868.547 | 728.0210 |
| ne02 | 31.63333 | 16.84545 | 541.8582 | 212.1680 | 1833.359 | 658.8014 |
| ne03 | 34.90911 | 16.29910 | 569.7533 | 143.6087 | 1641.323 | 570.6210 |

``` r
means_vot_group <- data_final %>%
  group_by(group) %>%
  summarise(vot_mean = mean(vot), vot_sd = sd(vot))

kable(means_vot_group)
```

| group | vot_mean |   vot_sd |
|:------|---------:|---------:|
| bi    | 20.41104 | 15.35773 |
| ne    | 31.58326 | 16.61162 |

## Visualization

``` r
# Include some plots here

# VOT as a function of item

data_final %>%
  ggplot(aes(x = vot, y = item, color = id)) +
  geom_point() +
  facet_grid(~ group)
```

<img src="README_files/figure-gfm/plots-1.png" width="672" />

``` r
# F1 as a function of item

data_final %>%
  ggplot(aes(x = f1, y = item, color = id)) +
  geom_point() +
  facet_grid(~ group)
```

<img src="README_files/figure-gfm/plots-2.png" width="672" />

``` r
# F2 as a function of item

data_final %>%
  ggplot(aes(x = f2, y = item, color = id)) +
  geom_point() +
  facet_grid(~ group)
```

<img src="README_files/figure-gfm/plots-3.png" width="672" />

``` r
# VOT as a function of participant

data_final %>%
  ggplot(aes(x = id, y = vot, fill = group)) +
  geom_boxplot()
```

<img src="README_files/figure-gfm/plots-4.png" width="672" />

``` r
# F1 as a function of participant

data_final %>%
  ggplot(aes(x = id, y = f1, fill = group)) +
  geom_boxplot()
```

<img src="README_files/figure-gfm/plots-5.png" width="672" />

``` r
# F2 as a function of participant

data_final %>%
  ggplot(aes(x = id, y = f2, fill = group)) +
  geom_boxplot()
```

<img src="README_files/figure-gfm/plots-6.png" width="672" />

``` r
# VOT as a function of stop type (and vowel) and group

plot_va = filter(data_final, item == "kaka" | item == "paka" | item == "taka") 
ggplot(plot_va, aes(x = item, y = vot, fill = group)) + 
  geom_boxplot() +
  facet_wrap(~ group)
```

<img src="README_files/figure-gfm/plots-7.png" width="672" />

``` r
plot_ve = filter(data_final, item == "keke" | item == "peke" | item == "teke") 
ggplot(plot_ve, aes(x = item, y = vot, fill = group)) + 
  geom_boxplot() +
  facet_wrap(~ group)
```

<img src="README_files/figure-gfm/plots-8.png" width="672" />

``` r
plot_vi = filter(data_final, item == "kiki" | item == "piki" | item == "tiki") 
ggplot(plot_vi, aes(x = item, y = vot, fill = group)) + 
  geom_boxplot() +
  facet_wrap(~ group)
```

<img src="README_files/figure-gfm/plots-9.png" width="672" />

``` r
plot_vo = filter(data_final, item == "koko" | item == "poko" | item == "toko") 
ggplot(plot_vo, aes(x = item, y = vot, fill = group)) + 
  geom_boxplot() +
  facet_wrap(~ group)
```

<img src="README_files/figure-gfm/plots-10.png" width="672" />

``` r
plot_vu = filter(data_final, item == "kuku" | item == "puku" | item == "tuku") 
ggplot(plot_vu, aes(x = item, y = vot, fill = group)) + 
  geom_boxplot() +
  facet_wrap(~ group)
```

<img src="README_files/figure-gfm/plots-11.png" width="672" />

``` r
# F1 as a function of stop type (and vowel) and group

plot_f1a = filter(data_final, item == "kaka" | item == "paka" | item == "taka") 
ggplot(plot_f1a, aes(x = item, y = f1, fill = group)) + 
  geom_boxplot() +
  facet_wrap(~ group)
```

<img src="README_files/figure-gfm/plots-12.png" width="672" />

``` r
plot_f1e = filter(data_final, item == "keke" | item == "peke" | item == "teke") 
ggplot(plot_f1e, aes(x = item, y = f1, fill = group)) + 
  geom_boxplot() +
  facet_wrap(~ group)
```

<img src="README_files/figure-gfm/plots-13.png" width="672" />

``` r
plot_f1i = filter(data_final, item == "kiki" | item == "piki" | item == "tiki") 
ggplot(plot_f1i, aes(x = item, y = f1, fill = group)) + 
  geom_boxplot() +
  facet_wrap(~ group)
```

<img src="README_files/figure-gfm/plots-14.png" width="672" />

``` r
plot_f1o = filter(data_final, item == "koko" | item == "poko" | item == "toko") 
ggplot(plot_f1o, aes(x = item, y = f1, fill = group)) + 
  geom_boxplot() +
  facet_wrap(~ group)
```

<img src="README_files/figure-gfm/plots-15.png" width="672" />

``` r
plot_f1u = filter(data_final, item == "kuku" | item == "puku" | item == "tuku") 
ggplot(plot_f1u, aes(x = item, y = f1, fill = group)) + 
  geom_boxplot() +
  facet_wrap(~ group)
```

<img src="README_files/figure-gfm/plots-16.png" width="672" />

``` r
# F2 as a function of stop type (and vowel) and group

plot_f2a = filter(data_final, item == "kaka" | item == "paka" | item == "taka") 
ggplot(plot_f2a, aes(x = item, y = f2, fill = group)) + 
  geom_boxplot() +
  facet_wrap(~ group)
```

<img src="README_files/figure-gfm/plots-17.png" width="672" />

``` r
plot_f2e = filter(data_final, item == "keke" | item == "peke" | item == "teke") 
ggplot(plot_f2e, aes(x = item, y = f2, fill = group)) + 
  geom_boxplot() +
  facet_wrap(~ group)
```

<img src="README_files/figure-gfm/plots-18.png" width="672" />

``` r
plot_f2i = filter(data_final, item == "kiki" | item == "piki" | item == "tiki") 
ggplot(plot_f2i, aes(x = item, y = f2, fill = group)) + 
  geom_boxplot() +
  facet_wrap(~ group)
```

<img src="README_files/figure-gfm/plots-19.png" width="672" />

``` r
plot_f2o = filter(data_final, item == "koko" | item == "poko" | item == "toko") 
ggplot(plot_f2o, aes(x = item, y = f2, fill = group)) + 
  geom_boxplot() +
  facet_wrap(~ group)
```

<img src="README_files/figure-gfm/plots-20.png" width="672" />

``` r
plot_f2u = filter(data_final, item == "kuku" | item == "puku" | item == "tuku") 
ggplot(plot_f2u, aes(x = item, y = f2, fill = group)) + 
  geom_boxplot() +
  facet_wrap(~ group)
```

<img src="README_files/figure-gfm/plots-21.png" width="672" />

# Praat pictures

## Hypothesis test

``` r
# Conduct a simple statistical analysis here (optional)
```

# Conclusion

The initial hypothesis was that the L2 learners will have longer VOTs
due to the influence of their L1. After analyzing the data, specifically
the VOT averages for bilingual participants compared to the VOT averages
for L2 learners, we can see that each individual L2 learner had longer
VOT than the bilingual participants.

``` r
kable(bi_means)
```

| id   | vot_mean |    vot_sd |  f1_mean |    f1_sd |  f2_mean |    f2_sd |
|:-----|---------:|----------:|---------:|---------:|---------:|---------:|
| bi01 | 26.19733 | 23.572779 | 520.2511 | 138.3988 | 1727.237 | 666.6207 |
| bi02 | 17.86356 |  7.542213 | 525.0113 | 132.9608 | 1588.668 | 677.9067 |
| bi03 | 17.17222 |  7.357463 | 612.5673 | 239.1793 | 1711.122 | 699.1391 |

``` r
kable(ne_means)
```

| id   | vot_mean |   vot_sd |  f1_mean |    f1_sd |  f2_mean |    f2_sd |
|:-----|---------:|---------:|---------:|---------:|---------:|---------:|
| ne01 | 28.20733 | 16.37009 | 608.5418 | 235.1716 | 1868.547 | 728.0210 |
| ne02 | 31.63333 | 16.84545 | 541.8582 | 212.1680 | 1833.359 | 658.8014 |
| ne03 | 34.90911 | 16.29910 | 569.7533 | 143.6087 | 1641.323 | 570.6210 |

Additionally, taken as a whole, the L2 learner group also had longer VOT
than the bilingual group.

``` r
kable(means_vot_group)
```

| group | vot_mean |   vot_sd |
|:------|---------:|---------:|
| bi    | 20.41104 | 15.35773 |
| ne    | 31.58326 | 16.61162 |

# Reflections

This was a VERY long assignment. In my opinion, the most complicated
part was understanding what had to be done every time. I felt like the
instruction were not as detailed compared to the three previous
programming assignments and I never really knew if I was doing what was
supposed to be done. Also, segmenting all the files took a very long
time. The R part was relatively easy. However, I believe this assignment
was very complete. I was able to apply all the skills I learned in this
class.

</br></br>
