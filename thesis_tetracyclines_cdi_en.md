# Tetracyclines and the risk of *Clostridioides difficile* infection
## Evidence summary and proposal for a Bayesian meta-analysis

*Document prepared as a medical-student graduation thesis proposal — Infectious Diseases*

---

## Part 1 — Evidence summary

### The clinical question
The choice of antibiotic in patients at high risk of *Clostridioides difficile* infection (CDI) remains a practical dilemma. It has long been observed that tetracyclines — particularly doxycycline — may be associated with a **lower** risk of CDI than other antibiotic classes, but individual study results are partly conflicting.

### What the data show
The evidence comes from three converging lines:

1. **Class-comparison meta-analyses.** In two independent community-associated CDI meta-analyses (2013), tetracyclines are the only class that does **not** increase risk (OR ~0.91–0.92), whereas clindamycin, fluoroquinolones and cephalosporins show the largest increases (Figure 1a).
2. **Dedicated meta-analysis (Tariq et al., *Clinical Infectious Diseases*, 2018).** Six studies (4 case-control, 2 cohort; recruitment 1993–2012) show that tetracyclines are associated with a **decreased** risk of CDI relative to other antibiotics: pooled OR **0.62** (95% CI 0.47–0.81; p < 0.001); in the doxycycline subgroup OR **0.55** (95% CI 0.40–0.75). Heterogeneity is substantial (I² = 53%) (Figure 1b).
3. **Larger recent dataset (VA, 2024).** In patients with community-acquired pneumonia, doxycycline versus azithromycin reduced CDI risk by ~17% (and by ~45% in patients with a prior history of CDI).

### Biological plausibility
Tetracyclines disrupt the anaerobic colonic microbiota less than clindamycin, cephalosporins and fluoroquinolones; in addition, doxycycline and tigecycline can reduce toxin production and possess anti-inflammatory properties independent of antibacterial activity.

### Limitations (fundamental)
- **All human evidence is observational** — no RCT. Confounding by indication is the principal threat.
- "Lower risk," not "protective therapy": the evidence supports **preferring** a tetracycline when clinically appropriate (an antimicrobial-stewardship argument), not prophylactic or therapeutic use against CDI.
- Non-trivial heterogeneity (I² ~53%).
- Tetracycline resistance is common in clinical *C. difficile* isolates (often via the mobile *tetM* element) — an ecological observation, distinct from patient-level risk.

![Figure 1]({{artifact:0a9fdda4-e06a-4c13-9513-b3d584105df6}})

**Figure 1.** *(a)* Community-associated CDI risk by antibiotic class (odds ratio vs no exposure; tetracyclines, in red, are the only class compatible with no increase in risk). *(b)* Pooled effect of tetracyclines vs other antibiotics (Tariq et al. 2018). Log scale; the dashed line marks OR = 1.

---

## Part 2 — Thesis proposal: a Bayesian meta-analysis

### Proposed title
**"Tetracyclines and the risk of *Clostridioides difficile* infection: a Bayesian random-effects meta-analysis with prior-sensitivity analysis"**

### Methodological rationale
The existing frequentist meta-analysis (Tariq 2018) has two features that make a Bayesian approach particularly suitable:
- **Few estimates (k = 6) and marked heterogeneity (I² ≈ 53%)**: with few studies, the frequentist estimate of the between-study variance (τ²) is unstable and confidence intervals tend to be too narrow. A Bayesian hierarchical model estimates τ² with its full uncertainty.
- **Observational nature with potential confounding**: priors allow scepticism toward observational estimates to be incorporated explicitly, and let us quantify how much the conclusions depend on that scepticism.

### Objectives
1. **Primary:** estimate the pooled OR (with a 95% credible interval) of the tetracycline–CDI association using a Bayesian hierarchical random-effects model.
2. **Secondary:** (a) estimate τ² and the predictive distribution for a new study; (b) compute the **posterior probability** that OR < 1 and that OR < 0.80 (a clinically relevant threshold); (c) doxycycline subgroup analysis; (d) prior-sensitivity analysis.

### Question and design (PECO)
- **P** — patients exposed to systemic antibiotics;
- **E** — exposure to a tetracycline (doxycycline, minocycline, tigecycline);
- **C** — exposure to other antibiotics / no tetracycline;
- **O** — incident CDI (microbiological/clinical diagnosis).
- **Design:** systematic review + Bayesian meta-analysis, conducted per **PRISMA 2020**; protocol pre-registered on **PROSPERO**.

### Methods (work plan for the student)

**1. Search and selection.** Search strings on PubMed/MEDLINE, Embase, Web of Science and Cochrane, from 2016 (end of Tariq's search) to the present, to update the corpus. Two independent reviewers, conflict resolution, PRISMA flow diagram. Quality assessed with the **Newcastle-Ottawa Scale**.

**2. Data extraction.** For each study: design, setting, population, sample size, CDI definition, adjusted OR/HR and CI, adjustment covariates. Convert all estimates to the **log(OR)** scale with their standard error.

**3. Statistical model (random-effects, hierarchical).**
For study *i*, with observed estimate *yᵢ* = log(ORᵢ) and standard error *sᵢ*:

    yᵢ  ~  Normal(θᵢ, sᵢ²)              (likelihood, sᵢ known)
    θᵢ  ~  Normal(μ, τ²)                (between-study random effects)
    μ   ~  Normal(0, 1²)                (prior on the pooled effect — see below)
    τ   ~  Half-Normal(0, 0.5)          (weakly informative prior on heterogeneity)

- **μ** is the pooled effect on the log(OR) scale; report exp(μ) as the OR.
- **τ** is the between-study standard deviation; a *half-Normal* or *half-Cauchy* is preferable to a uniform prior when k is small.

**4. Prior-sensitivity analysis (the methodological core of the thesis).** Compare at least three priors on μ:
- **non-informative / vague:** Normal(0, 10²);
- **sceptical:** Normal(0, 0.35²) — centres expectation on no effect, penalises large effects;
- **enthusiastic / literature-informed:** Normal(log 0.62, ~0.10²), centred on Tariq's estimate.
Show how the posterior estimate and P(OR<1) vary across priors (robustness).

**5. Computation.** MCMC (Hamiltonian Monte Carlo). Recommended tools, all free:
- **R** with `brms` or `rjags`/`R2jags`, or the `bayesmeta` package (designed exactly for this model and very easy to use for a thesis);
- alternatively **Python** with `PyMC`.
Convergence diagnostics: R-hat < 1.01, adequate ESS, trace plots.

**6. Output and presentation.**
- Bayesian forest plot with credible intervals and the pooled estimate (like Figure 1b);
- posterior density of μ (like Figure 2a) and the estimate of τ;
- a table of P(OR<1) and P(OR<0.80) for each prior;
- **predictive distribution** for a new study;
- numerical comparison with Tariq's frequentist estimate.

![Figure 2]({{artifact:50b27102-b7f9-4598-9b1f-30f66337c784}})

**Figure 2.** Key concepts of the method. *(a)* Bayesian updating: the sceptical *prior* (blue) combined with the data likelihood (grey) yields the posterior distribution (red) of the pooled effect. *(b)* Hierarchical model: individual study estimates (grey) are "shrunk" toward the common effect (red line) in inverse proportion to their precision. **The study-level values in panel (b) are illustrative**, for teaching purposes.

### Why it makes a good thesis
- **Feasible** within a few months: small dataset (k ≈ 6–10 studies), a standard model, free and well-documented software.
- **Rigorous and instructive:** teaches PRISMA systematic review, Bayesian inference, MCMC, and communication of uncertainty.
- **Clinically relevant:** translates the evidence into a directly interpretable probability ("what is the probability that tetracyclines truly reduce CDI risk?"), useful for stewardship.
- **Original relative to the literature:** no published Bayesian synthesis exists on this specific question; updating the post-2016 corpus adds value.

### Risks and mitigations
- *Few new studies since 2016* → the thesis remains valid as a **Bayesian re-analysis** of the existing corpus plus any update.
- *Heterogeneity in exposure/outcome definitions* → subgroup analysis and meta-regression (if k allows) or qualitative discussion.
- *Residual confounding (observational data)* → stated explicitly; the sceptical prior also serves this purpose.

### Indicative timeline (6 months)
| Month | Activity |
|---|---|
| 1 | Protocol, PROSPERO registration, search strings |
| 2 | Screening, selection, quality assessment (2 reviewers) |
| 3 | Data extraction, construction of the log(OR) dataset |
| 4 | Bayesian model implementation, MCMC diagnostics |
| 5 | Prior-sensitivity analysis, figures |
| 6 | Writing, discussion, final revision |

---

*Clinical note: this document is for research and educational purposes. Treatment decisions for individual patients rest with the treating physician, who has access to the full clinical picture.*
