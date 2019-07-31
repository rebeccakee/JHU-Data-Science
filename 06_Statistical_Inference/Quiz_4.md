Statistical Inference Week 4 Quiz
=================================

Q1. A pharmaceutical company is interested in testing a potential blood
pressure lowering medication. Their first examination considers only
subjects that received the medication at baseline then two weeks later.
The data are as follows (SBP in mmHg):

    ##   subject baseline week2
    ## 1       1      140   132
    ## 2       2      138   135
    ## 3       3      150   151
    ## 4       4      148   146
    ## 5       5      135   130

Consider testing the hypothesis that there was a mean reduction in blood
pressure? Give the P-value for the associated two sided T test.

(Hint, consider that the observations are paired.)

    baseline <- c(140, 138, 150, 148, 135)
    week2 <- c(132, 135, 151, 146, 130)
    t.test(week2, baseline, alternative = "two.sided", paired = TRUE)

    ## 
    ##  Paired t-test
    ## 
    ## data:  week2 and baseline
    ## t = -2.2616, df = 4, p-value = 0.08652
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -7.5739122  0.7739122
    ## sample estimates:
    ## mean of the differences 
    ##                    -3.4

Q2. A sample of 9 men yielded a sample average brain volume of 1,100cc
and a standard deviation of 30cc. What is the complete set of values of
*μ*<sub>0</sub> that a test of *H*<sub>0</sub> : *μ* = *μ*<sub>0</sub>
would fail to reject the null hypothesis in a two sided 5% Students
t-test?

    # Calculate 95% confidence intervals
    n <- 9 
    mean <- 1100
    sd <- 30
    CI <- 1100 + c(-1, 1) * sd/sqrt(n) * qt(0.975,df=n-1)
    CI

    ## [1] 1076.94 1123.06

Q3. Researchers conducted a blind taste test of Coke versus Pepsi. Each
of four people was asked which of two blinded drinks given in random
order that they preferred. The data was such that 3 of the 4 people
chose Coke. Assuming that this sample is representative, report a
P-value for a test of the hypothesis that Coke is preferred to Pepsi
using a one sided exact test.

    # We use pbinom (since there are only 2 outcomes, Coke versus Pepsi) to calculate 
    # the probability of more than 2 of 4 people choosing Coke
    # (since the observed data is 3/4 people chose Coke).

    pbinom(2, size = 4, prob = 0.5, lower.tail = FALSE)

    ## [1] 0.3125

Q4. Infection rates at a hospital above 1 infection per 100 person days
at risk are believed to be too high and are used as a benchmark. A
hospital that had previously been above the benchmark recently had 10
infections over the last 1,787 person days at risk. About what is the
one sided P-value for the relevant test of whether the hospital is
*below* the standard?

    lambda <- 1 / 100 * 1787
    ppois (10, lambda = lambda)

    ## [1] 0.03237153

Q5. Suppose that 18 obese subjects were randomized, 9 each, to a new
diet pill and a placebo. Subjects’ body mass indices (BMIs) were
measured at a baseline and again after having received the treatment or
placebo for four weeks. The average difference from follow-up to the
baseline (followup - baseline) was −3 kg/m2 for the treated group and 1
kg/m2 for the placebo group. The corresponding standard deviations of
the differences was 1.5 kg/m2 for the treatment group and 1.8 kg/m2 for
the placebo group. Does the change in BMI appear to differ between the
treated and placebo groups? Assuming normality of the underlying data
and a common population variance, give a pvalue for a two sided t test.

    options(scipen = 999)

    n.treated <- 9
    n.placebo <- 9
    mean.treated <- -3
    mean.placebo <- 1
    sd.treated <- 1.5
    sd.placebo <- 1.8

    pooled.sd <- sqrt(((n.treated - 1) * sd.treated^2 + (n.placebo - 1) * sd.placebo^2) / (n.treated + n.placebo - 2))

    t <- (mean.treated - mean.placebo) / (pooled.sd * sqrt(1 / n.treated + 1 / n.placebo))

    p <- 2 * pt(t, df = (n.treated + n.placebo - 2))
    p

    ## [1] 0.0001025174

Q6. Brain volumes for 9 men yielded a 90% confidence interval of 1,077
cc to 1,123 cc. Would you reject in a two sided 5% hypothesis test of
*H*<sub>0</sub> = 1, 078?

*Answer: No, you wouldn’t reject.*

Q7. Researchers would like to conduct a study of 100 healthy adults to
detect a four year mean brain volume loss of .01 *m**m*<sup>3</sup>.
Assume that the standard deviation of four year volume loss in this
population is .04 *m**m*<sup>3</sup>.About what would be the power of
the study for a 5% one sided test versus a null hypothesis of no volume
loss?

    power.t.test(n = 100, delta = 0.01, sd = 0.04, type = "one.sample", alternative = "one.sided")

    ## 
    ##      One-sample t test power calculation 
    ## 
    ##               n = 100
    ##           delta = 0.01
    ##              sd = 0.04
    ##       sig.level = 0.05
    ##           power = 0.7989855
    ##     alternative = one.sided

Q8. Researchers would like to conduct a study of *n* healthy adults to
detect a four year mean brain volume loss of .01 *m**m*<sup>3</sup>.
Assume that the standard deviation of four year volume loss in this
population is .04 *m**m*<sup>3</sup>. About what would be the value of
*n* needed for 90% power of type one error rate of 5% one sided test
versus a null hypothesis of no volume loss?

    power.t.test(power = 0.90, delta = 0.01, sd = 0.04, type = "one.sample", alternative = "one.sided")

    ## 
    ##      One-sample t test power calculation 
    ## 
    ##               n = 138.3856
    ##           delta = 0.01
    ##              sd = 0.04
    ##       sig.level = 0.05
    ##           power = 0.9
    ##     alternative = one.sided

Q9. As you increase the type one error rate, *α*, what happens to power?

*Answer: You will get larger power.*
