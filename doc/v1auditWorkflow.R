## -----------------------------------------------------------------------------
library(jfa)
data("BuildIt")

## -----------------------------------------------------------------------------
# Specify the materiality, confidence, and expected errors.
materiality   <- 0.05   # 5%
confidence    <- 0.95   # 95%
expectedError <- 0.025  # 2.5%

## -----------------------------------------------------------------------------
# Specify the inherent risk (ir) and control risk (cr).
ir <- 1     # 100%
cr <- 0.6   # 60%

## -----------------------------------------------------------------------------
# Adjust the required confidence for a frequentist analysis.
adjustedConfidence <- 1 - ((1 - confidence) / (ir * cr))

## -----------------------------------------------------------------------------
# Step 0: Create a prior distribution according to the audit risk model.
priorResult <- auditPrior(confidence = confidence, likelihood = "binomial", method = "arm", expectedError = expectedError, materiality = materiality, ir = ir, cr = cr)

## -----------------------------------------------------------------------------
print(priorResult)

## ----fig.align="center", fig.height=4, fig.width=6----------------------------
plot(priorResult)

## -----------------------------------------------------------------------------
# Step 1: Calculate the required sample size.
planningResult <- planning(confidence = confidence, expectedError = expectedError, materiality = materiality, prior = priorResult)

## -----------------------------------------------------------------------------
print(planningResult)

## ----fig.align="center", fig.height=4, fig.width=6----------------------------
plot(planningResult)

## -----------------------------------------------------------------------------
# Step 2: Draw a sample from the financial statements.
samplingResult <- selection(population = BuildIt, sampleSize = planningResult, units = "mus", bookValues = "bookValue", seed = 999)

## -----------------------------------------------------------------------------
print(samplingResult)

## -----------------------------------------------------------------------------
# Step 3: Isolate the sample for execution of the audit.
sample <- samplingResult$sample

# To write the sample to a .csv file:
# write.csv(x = sample, file = "auditSample.csv", row.names = FALSE)

# To load annotated sample back into R:
# sample <- read.csv(file = "auditSample.csv")

## -----------------------------------------------------------------------------
# Step 4: Evaluate the sample.
evaluationResult <- evaluation(sample = sample, materiality = materiality, prior = priorResult, bookValues = "bookValue", auditValues = "auditValue")

## -----------------------------------------------------------------------------
print(evaluationResult)

## ----fig.align="center", fig.height=4, fig.width=6----------------------------
plot(evaluationResult)

