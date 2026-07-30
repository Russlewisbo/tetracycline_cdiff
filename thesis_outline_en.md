# Thesis Outline — Detailed Chapter Plan

## Tetracyclines and the risk of *Clostridioides difficile* infection: an updated systematic review and Bayesian random-effects meta-analysis

*Graduation thesis (Tesi di Laurea), Medicine and Surgery — Infectious Diseases, University of Padua*
*Target length: 50–75 pages (main text, excluding references and appendices). Page budgets below are guidance for a double-spaced manuscript; they sum to ~62 pages of main text.*

---

### Front matter (unnumbered, ~4–6 pages)
- Title page (Italian + English title, candidate, supervisor, co-supervisor, academic year)
- Dedication / acknowledgements (optional)
- Abstract — Italian (**Riassunto**), ~1 page, structured: background, objectives, methods, results, conclusions
- Abstract — English, ~1 page, same structure
- Table of contents; list of figures; list of tables; list of abbreviations (CDI, CDAD, OR, HR, CI, CrI, NOS, RoB 2, GRADE, MCMC, ICC, τ², I²)

---

## Chapter 1 — Introduction and Background  *(target ~16–20 pages)*

**1.1 *Clostridioides difficile* and its clinical burden** *(~3 pp)*
- Microbiology: Gram-positive, spore-forming, toxigenic anaerobe; reclassification *Clostridium → Clostridioides* (2016)
- Toxins A (TcdA) and B (TcdB), binary toxin (CDT); the PaLoc locus
- Epidemiology: incidence trends, healthcare- vs community-associated CDI, the hypervirulent ribotype 027/NAP1/BI epidemic
- Clinical spectrum: asymptomatic carriage → diarrhoea → pseudomembranous colitis → toxic megacolon; recurrence
- Burden: mortality, length of stay, healthcare cost; the Italian/European picture

**1.2 Pathogenesis and the role of the gut microbiota** *(~3 pp)*
- Colonisation resistance and how antibiotics disrupt it
- Bile-acid metabolism, short-chain fatty acids, and germination
- Why antibiotic exposure is the dominant modifiable risk factor

**1.3 Antibiotics as the principal driver of CDI risk** *(~4 pp)*
- Risk stratification by class: clindamycin, fluoroquinolones, cephalosporins (high); penicillins, macrolides, sulfonamides (intermediate); tetracyclines (low/neutral)
- Summary of the class-comparison meta-analyses (Deshpande 2013, Brown 2013) — *insert Figure: class OR forest plot*
- Antimicrobial stewardship as the lever: restriction, cycling, and the concept of "collateral damage"

**1.4 The tetracycline class** *(~3 pp)*
- Pharmacology: mechanism (30S ribosomal inhibition), spectrum, PK/PD
- Members: doxycycline, minocycline, tetracycline; glycylcyclines (tigecycline) and newer agents (eravacycline, omadacycline, sarecycline)
- Effect on the colonic anaerobic microbiota relative to high-risk classes
- Postulated antibiotic-independent effects: anti-toxin, anti-inflammatory, anti-sporulation (tigecycline)
- Note on tetracycline resistance in *C. difficile* (tetM, mobile elements) — an ecological caveat distinct from patient-level risk

**1.5 The existing evidence and its limitations** *(~2 pp)*
- The Tariq et al. 2018 meta-analysis: design, six studies, pooled OR 0.62 (doxycycline 0.55), I² = 53%
- Gaps: all observational, confounding by indication, few studies, no Bayesian synthesis, search ended 2016
- Newer signals (e.g. large VA doxycycline-pneumonia dataset, 2024)

**1.6 Rationale and aims of this thesis** *(~2 pp)*
- Why update, and why Bayesian
- Primary and secondary objectives (mirroring the protocol)
- Research question in PECO format

---

## Chapter 2 — Methods  *(target ~14–16 pages)*

**2.1 Protocol, registration, and reporting standards** *(~1 p)*
- PROSPERO registration (ID, date); PRISMA 2020 and PRISMA-P 2015 adherence; deviations log

**2.2 Eligibility criteria** *(~2 pp)*
- Full PECO-S; inclusion/exclusion table; operational CDI definition; handling of the six Tariq studies (carried forward, re-verified)

**2.3 Information sources and search strategy** *(~3 pp)*
- The four databases + grey literature/trial registries + citation chasing
- Reproduce the four database-specific strings verbatim (from protocol §15) as a boxed appendix reference
- Search dates and the executed PubMed pilot results *(insert Figure: search yield)*

**2.4 Study selection** *(~1 p)*
- De-duplication, Rayyan/Covidence, dual independent screening, κ, PRISMA flow diagram *(insert Figure: PRISMA flow — to be completed after screening)*

**2.5 Data extraction** *(~2 pp)*
- Piloted form, data items list, adjusted-estimate preference, log(OR) conversion, handling of RR/HR, contacting authors

**2.6 Risk-of-bias and certainty assessment** *(~2 pp)*
- Newcastle-Ottawa Scale (observational), RoB 2 (RCT), GRADE (body of evidence)

**2.7 Statistical analysis — the Bayesian model** *(~4 pp; the methodological heart)*
- Effect measure and log(OR) scale; the hierarchical random-effects specification (likelihood → θᵢ → μ, τ priors) — *insert equations*
- Prior choices and the three-prior sensitivity analysis (vague / sceptical / literature-informed) *(insert Figure: Bayesian updating concept)*
- Posterior quantities: pooled OR + 95% CrI, τ, predictive distribution, P(OR<1), P(OR<0.80)
- Shrinkage and the hierarchical logic *(insert Figure: shrinkage concept)*
- Subgroups (doxycycline; design; setting; adjustment), meta-regression if k≥10
- Software (R `brms`/`bayesmeta` or `PyMC`), MCMC settings, convergence diagnostics (R-hat, ESS, trace)
- Frequentist DL/REML comparison; funnel plot / Egger if k≥10
- Sensitivity analyses summary table

---

## Chapter 3 — Results  *(target ~12–15 pages)*

**3.1 Search and selection results** *(~2 pp)*
- Records identified per database, deduplicated, screened, excluded (reasons), included — PRISMA flow diagram
- Reconciliation with Tariq's six studies

**3.2 Characteristics of included studies** *(~3 pp)*
- Master characteristics table (author, year, country, design, setting, n, CDI definition, tetracycline agent, comparator, adjusted estimate, covariates)
- Narrative description of the evidence base

**3.3 Risk of bias** *(~2 pp)*
- NOS and RoB 2 summary figures/tables; per-domain traffic-light plot

**3.4 Primary Bayesian meta-analysis** *(~3 pp)*
- Pooled OR + 95% CrI; Bayesian forest plot *(insert Figure)*; posterior density of μ; τ estimate; predictive interval
- P(OR<1) and P(OR<0.80)

**3.5 Prior-sensitivity analysis** *(~2 pp)*
- Posterior and P(OR<1) across the three priors — table + figure; robustness statement

**3.6 Subgroup, meta-regression, and sensitivity analyses** *(~2 pp)*
- Doxycycline subgroup; design-stratified; setting; adjusted-only; high-quality-only
- Frequentist comparison; small-study-effects assessment

---

## Chapter 4 — Discussion  *(target ~10–12 pages)*

**4.1 Summary of principal findings** *(~2 pp)* — plain-language statement of the posterior and its clinical translation
**4.2 Comparison with prior evidence** *(~2 pp)* — vs Tariq 2018 and the class-comparison literature; what the update and the Bayesian lens add
**4.3 Biological and clinical interpretation** *(~2 pp)* — mechanism; the "lower risk ≠ protective therapy" distinction; stewardship implications
**4.4 Strengths** *(~1 p)* — Bayesian uncertainty handling, prior sensitivity, updated and complete corpus, dual methods
**4.5 Limitations** *(~2 pp)* — observational designs, confounding by indication, residual heterogeneity, few RCTs, exposure heterogeneity (class vs doxycycline), resistance caveat, publication bias
**4.6 Implications for practice and research** *(~2 pp)* — stewardship; the case (or not) for a pragmatic RCT; registry/target-trial-emulation opportunities

---

## Chapter 5 — Conclusions  *(target ~1–2 pages)*
- Concise restatement of the answer to the research question and its confidence
- One-paragraph clinical bottom line

---

### Back matter
- **References** (Vancouver style; ~60–100 citations; not counted in page target)
- **Appendices** (not counted): full search strings for all four databases; PRISMA 2020 checklist; data-extraction form; NOS/RoB 2 instruments; complete statistical code (R/Python); supplementary posterior plots and convergence diagnostics; PROSPERO record

---

### Figures already prepared (drop-in ready)
1. Class-comparison forest plot *(§1.3)* — `figure1_forest_en.png`
2. Bayesian updating + shrinkage concept *(§2.7, §3.4)* — `figure2_bayes_en.png`
3. PubMed search yield *(§2.3)* — `figure3_search_yield.png`
4. *To be produced during the work:* PRISMA flow diagram, RoB traffic-light plot, Bayesian forest plot of results, prior-sensitivity panel.

### Suggested writing order for the student
1. **Methods** first (it is fixed by the protocol — fastest to draft and lock).
2. **Introduction/Background** next (can be written while screening proceeds).
3. **Results** as data accrue (tables and figures before prose).
4. **Discussion → Conclusions → Abstracts** last.
5. References managed in Zotero/EndNote throughout.

### Page-budget summary
| Section | Pages |
|---|---|
| Front matter | 4–6 |
| 1 Introduction/Background | 16–20 |
| 2 Methods | 14–16 |
| 3 Results | 12–15 |
| 4 Discussion | 10–12 |
| 5 Conclusions | 1–2 |
| **Main-text total** | **~53–65** |

*Clinical note: this outline supports an academic evidence-synthesis thesis; it is not clinical guidance. Any practice implications drawn in Chapter 4 must be framed as stewardship considerations for clinician judgement, not patient-specific recommendations.*
