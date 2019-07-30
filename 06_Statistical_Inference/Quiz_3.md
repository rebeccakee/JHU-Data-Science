Statistical Inference Week 3 Quiz
=================================

Q1. In a population of interest, a sample of 9 men yielded a sample
average brain volume of 1,100cc and a standard deviation of 30cc. What
is a 95% Student’s T confidence interval for the mean brain volume in
this new population?

    n <- 9 
    mean <- 1100
    sd <- 30
    CI <- 1100 + c(-1, 1) * sd/sqrt(n) * qt(0.975,df=n-1) # We multiply by sd/sqrt(n), the standard error, given that we're interested in the CI for the mean brain volume.
    CI 

    ## [1] 1076.94 1123.06

Q2. A diet pill is given to 9 subjects over six weeks. The average
difference in weight (follow up - baseline) is -2 pounds. What would the
standard deviation of the difference in weight have to be for the upper
endpoint of the 95% T confidence interval to touch 0?

    n <- 9 
    mean <- -2 
    sd <- round(-mean / qt(0.975,df=n-1) * sqrt(n), 2)

Q3. In an effort to improve running performance, 5 runners were either
given a protein supplement or placebo. Then, after a suitable washout
period, they were given the opposite treatment. Their mile times were
recorded under both the treatment and placebo, yielding 10 measurements
with 2 per subject. The researchers intend to use a T test and interval
to investigate the treatment. Should they use a paired or independent
group T test and interval?

Answer: They should use a paired T test and interval.

Q4. In a study of emergency room waiting times, investigators consider a
new and the standard triage systems. To test the systems, administrators
selected 20 nights and randomly assigned the new triage system to be
used on 10 nights and the standard system on the remaining 10 nights.
They calculated the nightly median waiting time (MWT) to see a
physician. The average MWT for the new system was 3 hours with a
variance of 0.60 while the average MWT for the old system was 5 hours
with a variance of 0.68. Consider the 95% confidence interval estimate
for the differences of the mean MWT associated with the new system.
Assume a constant variance. What is the interval? Subtract in this order
(New System - Old System).

    n.old <- 10
    n.new <- 10
    mean.old <- 5
    mean.new <- 3
    variance.old <- 0.68
    variance.new <- 0.60

    pooled.sd <- sqrt(((n.new - 1) * variance.new + (n.old - 1) * variance.old) / (n.new + n.old - 2))

    CI <- mean.new - mean.old + c(-1, 1) * qt(0.975, df = n.old + n.new - 2) * pooled.sd * sqrt(1 / n.new + 1 / n.old)
    CI

    ## [1] -2.751649 -1.248351

Q5. Suppose that you create a 95% T confidence interval. You then create
a 90% interval using the same data. What can be said about the 90%
interval with respect to the 95% interval?

Answer: The interval will be narrower.

Q6. To further test the hospital triage system, administrators selected
200 nights and randomly assigned a new triage system to be used on 100
nights and a standard system on the remaining 100 nights. They
calculated the nightly median waiting time (MWT) to see a physician. The
average MWT for the new system was 4 hours with a standard deviation of
0.5 hours while the average MWT for the old system was 6 hours with a
standard deviation of 2 hours. Consider the hypothesis of a decrease in
the mean MWT associated with the new treatment.

What does the 95% independent group confidence interval with unequal
variances suggest vis a vis this hypothesis? (Because there’s so many
observations per group, just use the Z quantile instead of the T.)

    n.old <- 100
    n.new <- 100
    mean.old <- 6
    mean.new <- 4
    sd.old <- 2
    sd.new <- 0.50

    pooled.sd <- sqrt(((n.new - 1) * sd.new^2 + (n.old - 1) * sd.old^2) / (n.new + n.old - 2))

    CI <- mean.old - mean.new + c(-1, 1) * qt(0.975, df = n.old + n.new - 2) * pooled.sd * sqrt(1 / n.new + 1 / n.old)
    CI

    ## [1] 1.593458 2.406542

Answer: When subtracting (old - new) the interval is entirely above
zero. The new system appears to be effective.

Q7. Suppose that 18 obese subjects were randomized, 9 each, to a new
diet pill and a placebo. Subjects’ body mass indices (BMIs) were
measured at a baseline and again after having received the treatment or
placebo for four weeks. The average difference from follow-up to the
baseline (followup - baseline) was −3 kg/m2 for the treated group and 1
kg/m2 for the placebo group. The corresponding standard deviations of
the differences was 1.5 kg/m2 for the treatment group and 1.8 kg/m2 for
the placebo group. Does the change in BMI over the four week period
appear to differ between the treated and placebo groups? Assuming
normality of the underlying data and a common population variance,
calculate the relevant 90% t confidence interval. Subtract in the order
of (Treated - Placebo) with the smaller (more negative) number first.

    n.treated <- 9
    n.placebo <- 9
    mean.treated <- -3
    mean.placebo <- 1
    sd.treated <- 1.5
    sd.placebo <- 1.8

    pooled.sd <- sqrt(((n.treated - 1) * sd.treated^2 + (n.placebo - 1) * sd.placebo^2) / (n.treated + n.placebo - 2))

    CI <- mean.treated - mean.placebo + c(-1, 1) * qt(0.95, df = n.treated + n.placebo - 2) * pooled.sd * sqrt(1 / n.treated + 1 / n.placebo)
    CI

    ## [1] -5.363579 -2.636421
