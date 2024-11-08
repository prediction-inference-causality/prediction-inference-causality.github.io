# General Thoughts
- Review at beginning of class is helpful but time consuming.
 - Some lectures this semester wound up being 2 classes. 
  - Keep that.  Minimal 'within-lecture' review. 
  - Remind students where day 1 ends/day 2 begins by using link that jumps to the section where day 2 starts on the website.
 - Have review at the beginning of 'new' lectures. 
 - Remind students that before day 2 of '2 day lectures' they should make sure they're good to continue.

# Lecture 1 
- Seemed good. A little long. Maybe 10-15 min. 
- Cut some later stuff? 

# Lab 1
- Also good. Also long, even eliding all programming content and discussion stuff.  
 - Probably fits well in a full class period with discussion/programming stuff minimized.  
 - To enable more discussion, cut the number of sampling schemes to 3+small
  - Don't do both 'sampling w/o replacement' and 'permutation sampling'. -1 
    - Too cute and too much time. Just call it sampling w/ replacement.
    - And give both the urn model and shuffling interpretations.
  - Blow through randomization the sampling super quick    +small
 - Give the population more to do? Maybe kick off discussion?

# Lab 2 
- Just make it be on programming. Focus on the code from lab one.
- Like the stuff that's in there at the start + the functional programming stuff.
- Move a little bit of the Binary RVs stuff to HW 1?
- Talk briefly about variable scope in R and why that, in part, makes it better to use map vs loops.

# Lab 3 (Expectations)

- Too long. Swap w/ the Bootstrap lecture to get a normal class period. 
- Do the Lab 2 stuff on RVs, e.g. what is an RV, there after a small amount in HW. 
- Anticipatory HW stuff
  - Have them answer 'What is a Random Variable?'. Guidance to do it quickly without thinking too hard. 1 minute answer.
  - Have them calculate expectations for binary RVs from first principles, including both {0,1} and {-1,1} RVS.
- For more examples in intro: There are some rules for this stuff, but let’s do it from first principles. We’ll get to the rules later. Maybe?
- Check whether there's stuff from lecture on Cond Expectations that we want to borrow 
  - e.g. connection between population mean and variance and RVs drawn uniformly-at-random. 
- Figure out some way of doing irrelevance of 'independent' conditioning variables 
  - The point: unbiasedness of subsample mean when sampling w/ replacement
  - It is unbiased, right?
  
# Bootstrap Lecture

- Short. Swap to lab (3) works.
- Swap out the difference in means example for estimating a mean when outcomes aren't binary.

# Homework Changes 
- Move stuff on 'binom.width' and how the function 'width' works from the Week 2 Homework to the Week 1 Homework. 
- Cut the 'What would you choose' stuff from the Week 3 Homework. E.g. the last problem.
  - Do it the following week. Maybe as a class discussion rather than a HW problem.
  - Do it after we've done the stuff on bias and inference.
- Have a whole HW on choosing estimators, using an elaborate solution to Week 3 HW's bias/sd/mse sketching problem as a starting point.
- Have a meeting, maybe a Friday, dedicated to discussing it.  And why people use things like the prior obs estimator despite possible issues.
- Cut the 'proving Markov's inequality' stuff from HW3. 
  - You basically prove it anyway by providing an 'outline'. 
  - Just rephrase as an actual proof.
  
# Practice Midterm 1 
 - Replace Brewery problem with a simple question on interval calibration.
  - Maybe do sex dimorphism in Wolves example from my consulting class at Columbia.
  - But keep it really straightforward.
 - Try to have 20-30 min in review session where we're not talking about specific questions but about strategies for minimizing errors. 
  - Type checking: $E Y$ is a constant and $E[Y|X]$ is a function of $X$.
  - Plot measuring. When you do it on a calculation, draw it into a plot. 
    - This should help you see if you've made an error, e.g. are an order of magnitude off or something.
  - Point out that I've asked you to do the drawing stuff on HW; it's important to start doing it w/o prompting.
  - Have examples of errors people have made.


# More Stuff Before Midterm 1 

- More stuff on the bootstrap after we introduce conditioning and can talk about it formally.
  - Cover stuff that was extra credit on midterm 1.
  - Do bias estimate / bias correction stuff 
  - This can be HW, but do review it. 
- Do implications of bias for inference right after normal approximation.
  - Use the mean w/prior obs as an example. 
- Do Brewery problem from Practice Exam 1 as a case study in class. Maybe a Friday.
  - Introduce 1-sided CIs there, as done in extended soln on practice exam. 
- Do a day on non-uniform sampling after Lecture 6.
  - Revisit bias + variance calculations. 
  - Talk about improved / optimal allocation.
- Have a discussion (a Friday?) on the need for priors when we might have empty columns. That is, pull out the stuff from the note 'A quirk' in the week 9 hw and do it before, as a class discussion. Whether to do it before or after midterm 1, who knows? To get there in the simplest form possible, maybe do it before, with a small sample version of the difference in means thing. 
- All this means Midterm 1 will be pushed back a bit. A least a week and probably two. 

## Lecture 8

- This went poorly. Too much complexity at once.
- Reorganize to be a little more sectioned / focused on one thing at a time.
- I think this needs two days. One on unbiasedness, one on variance.
- Also: the 'forgetting' heuristic should come up earlier, in Lecture 6.
- Maybe this organization? 
  - Intro
    - Recall two high school summaries of the population.
    - Point out that we can estimate them using analogous summaries of the sample.
    - And bootstrap them to estimate their sampling distributions widths.
    - Two questions.
     - About coverage: Bias would be a problem. Are they biased? If so, how much?
     - About precision: Why is one so much narrower than the other? 
  - Quiz: which summary is the secant slope?
  - Unbiasedness 
   - Abstraction v1.
    - target: linear combination of subpopulation means.
    - estimator: linear combination of subsample means. 
    - unbiasedness picture + proof.
    - Examples w/ coefs. Board exercise.
      - column mean
      - difference of column means 
      - average over years / secant slope 
    - Not an Example: average over people.
   - Abstraction v2 (acknowledge as a generalization)
    - target: linear combination w/ coefficients that depend on covariates x_1 ... x_m
    - estimator: linear combination w/ coefficients that depend on the sample X_1 ... X_n
    - Examples. Probably state coefficient formulas but defer to homework/end of class. Or have done it already. Lab?
      - Multi-column mean. Including the whole population.
      - Average over people. 
    - Unbiasedness.
      - What do you think? Go example by example.
        - The whole population mean? It better be. We already showed it is in Lecture 4.
        - Multi-column means? Sure. 'Forgetting' argument.
        - Average over people. Go ahead and guess, but we'll revisit after doing a calculation.
      - Calculate the expectation in abstract, reducing question to *unbiasedness of coefficients*.  
        - The whole pop mean: coefficients are proportions. We know these are unbiased.
        - Multi-column means: coefficients are proportions within subsample. 
          - They should be. If we 'forget' the disused columns, these are just proportions. 
          - Formalization via conditioning. 2 stage sampling argument. Give it a slide with the stages.
        - Average over people. 
          - Put up unrolled formula. 
          - Q1. Are these coefficients unbiased? (Yes)
          - Q2. How do you know? (Linearity + Unbiasedness of proportions w/in subsample.) 
    - Resolving Question 1
      - 'The Recipe' gives us an unbiased estimator if the coefficients are unbiased.
      - Which happens if ...
        - The coefficients don't depend on the population/sample
        - The coefficients are sample proportions or differences of them
      - That'll cover basically everything we talk about in this class
  - Variance 
    - We'll do this in abstraction v2. Form + examples
    - Recall total variance and how it's come up before, e.g. in subsample mean variance calc.
    - Calculation, insofar as we want to include it
    - Interpretation for our two summaries
      - what is and isn't hard to estimate?
      - what's a lower bound good for?
    - Concluding discussion of (bad) common practice.
      - testing for differences and then using whichever.
      - minimal variance convex combinations?