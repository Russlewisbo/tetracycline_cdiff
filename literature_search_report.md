# Literature Search Report

## Tetracyclines and the risk of *Clostridioides difficile* infection — updated systematic review

*Search results summary supporting the PROSPERO protocol. Prepared 2026-07-13. This document records the pilot/scoping search executed in PubMed/MEDLINE; the Scopus, Embase and Cochrane CENTRAL strategies are specified in the protocol and are to be executed by the student through institutional access.*

---

### 1. Purpose
This report documents the executed literature search for the systematic review *"Tetracyclines and the risk of Clostridioides difficile infection: an updated systematic review and Bayesian random-effects meta-analysis."* It provides reproducible, dated hit counts for the PubMed strategy so the student can (a) gauge screening workload, (b) populate the PRISMA 2020 flow diagram, and (c) enter documented search results into the PROSPERO record.

### 2. Search parameters
- **Database executed:** PubMed / MEDLINE (NCBI E-utilities API).
- **Search date:** 2026-07-13.
- **Date window:** 1 January 2016 to search date (updating Tariq et al. 2018, whose search ended December 2016).
- **Structure:** two concept blocks combined with AND — (A) tetracyclines, (B) *C. difficile* infection — with no design or comparator filter at the search stage (maximising sensitivity; comparator and design applied at screening).
- **Full strategy:** see protocol §15.1 (verbatim, reproducible).

### 3. Headline results

| Query | Records |
|---|---|
| Block A — tetracyclines (all years) | 106,329 |
| Block B — *C. difficile* infection (all years) | 51,105 |
| A AND B — all years | 675 |
| **A AND B — 2016 to present (screening set)** | **302** |

The 2016-onward intersection of **302 records** is the PubMed contribution to the screening pool. The all-years figure of 675 is consistent with the volume screened by the prior meta-analysis and confirms the concept blocks are appropriately calibrated (neither over-narrow nor runaway-broad).

### 4. Composition of the 302 records

![Search yield]({{artifact:2e25aa92-12ce-44e4-a5a3-66ca82470959}})

**Figure.** *(a)* Annual yield of the PubMed search across the update window; 2026 is a partial (year-to-date) count. Records are distributed fairly evenly across years, with no single year dominating. *(b)* Records by publication type; the two design categories eligible for the review (observational studies and RCTs) are highlighted in blue. These publication-type filters overlap and are indicative, not a strict partition.

Publication-type breakdown (PubMed filters, 2016-onward; overlapping subsets):

| Subset | Records |
|---|---|
| English language | 294 |
| Observational (cohort / case-control / retrospective / prospective terms) | 45 |
| Reviews (any type) | 38 |
| Case reports | 22 |
| Systematic reviews / meta-analyses | 11 |
| Randomized controlled trials | 2 |

### 5. Interpretation and workload
- **~302 PubMed abstracts** is a manageable dual-reviewer screening volume for a graduation thesis.
- The **eligible design core is small**: ~45 records use explicit observational-design language and only ~2 are RCTs — validating the protocol's choice to treat observational studies as the evidence backbone and RCTs as a subgroup/sensitivity layer.
- Roughly **60 records** (38 reviews + 22 case reports) will be excluded at screening per the eligibility criteria but retained through export for backward citation-chasing.
- The publication years are evenly spread, indicating a steady rather than bursty literature — no single year will dominate the update.

### 6. Remaining searches (to be executed by the student)
The following strategies are fully specified in the protocol (§15.2–15.4) and must be run through institutional subscriptions:
- **Scopus** — `TITLE-ABS-KEY(...)`, `PUBYEAR > 2015`.
- **Embase** — Emtree + `.ti,ab,kw.`, `limit to yr="2016-Current"`.
- **Cochrane CENTRAL** — MeSH-descriptor + `:ti,ab,kw`, Trials, 2016–present.
- Plus ClinicalTrials.gov, WHO ICTRP, and citation-chasing of all included studies and of Tariq et al. 2018.

**Expected combined pool:** after de-duplication across the four databases, a realistic unique screening set of **~400–600 records**, from which the final included set (added to Tariq's six) is anticipated to be in the single digits to low teens.

### 7. Reproducibility note
PubMed counts were retrieved programmatically via the NCBI E-utilities `esearch` endpoint on the search date above. Counts in live databases change over time as records are added and reindexed; the student should re-run on the day of the definitive search and record the exact date and counts in the PRISMA flow diagram and the PROSPERO record. The verbatim search string (protocol §15.1) is the authoritative, reproducible specification.

---

*Clinical note: this document is a research and educational record supporting evidence synthesis; it does not constitute clinical guidance.*
