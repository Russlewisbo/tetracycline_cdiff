# Export all report figures as high-resolution PNGs (300 dpi) into figures/
# Mirrors the figure chunks in report.qmd. Run with: source("export_figures.R")

library(tidyverse)
library(bayesmeta)
library(metafor)

dir.create("figures", showWarnings = FALSE)

# ---- Setup (identical to report.qmd) ----
es   <- read_csv("tbl_es_analysis_ready.csv", show_col_types = FALSE)
prim <- es |> filter(use_in_primary == "Yes")

prim_abx   <- prim |> filter(comparator_type != "no_antibiotic")   # k = 11 (primary)
prim_noabx <- prim |> filter(comparator_type == "no_antibiotic")   # k = 9  (secondary)

hn <- function(t) dhalfnormal(t, scale = 0.5)

fit_prior <- function(df, mean, sd) {
  bayesmeta(y = df$yi, sigma = df$sei, labels = df$reference,
            mu.prior.mean = mean, mu.prior.sd = sd, tau.prior = hn)
}

summ <- function(f) {
  sm <- f$summary
  tibble(
    OR = exp(sm["median","mu"]), OR_lo = exp(sm["95% lower","mu"]), OR_hi = exp(sm["95% upper","mu"]),
    tau = sm["median","tau"], tau_lo = sm["95% lower","tau"], tau_hi = sm["95% upper","tau"],
    P_OR_lt_1 = f$pposterior(mu = 0), P_OR_lt_080 = f$pposterior(mu = log(0.80)),
    pred_lo = exp(sm["95% lower","theta"]), pred_hi = exp(sm["95% upper","theta"])
  )
}

fits_abx <- list(
  primary    = fit_prior(prim_abx, 0,         1),
  vague      = fit_prior(prim_abx, 0,         10),
  sceptical  = fit_prior(prim_abx, 0,         0.35),
  literature = fit_prior(prim_abx, log(0.62), 0.10)
)
res_abx <- imap_dfr(fits_abx, ~ summ(.x) |> mutate(prior = .y, .before = 1))

prim_abx2 <- prim_abx |>
  mutate(design_broad = if_else(str_detect(study_design, "cohort"), "cohort", "case_control"))
subs <- list(
  doxycycline  = prim_abx2 |> filter(exposure_class == "doxycycline"),
  case_control = prim_abx2 |> filter(design_broad == "case_control"),
  cohort       = prim_abx2 |> filter(design_broad == "cohort")
)
res_sub <- imap_dfr(subs, ~ summ(fit_prior(.x, 0, 1)) |>
                      mutate(analysis = .y, k = nrow(.x), .before = 1))

getp <- function(p) as.list(res_abx[res_abx$prior == p, ])
P <- getp("primary")

rma_abx <- rma(yi = prim_abx$yi, vi = prim_abx$sei^2, method = "REML")

loo <- map_dfr(seq_len(nrow(prim_abx)), function(i) {
  d <- prim_abx[-i, ]
  s <- summ(bayesmeta(y = d$yi, sigma = d$sei, labels = d$reference,
                      mu.prior.mean = 0, mu.prior.sd = 1, tau.prior = hn))
  tibble(dropped = prim_abx$reference[i],
         OR = s$OR, OR_lo = s$OR_lo, OR_hi = s$OR_hi, P1 = s$P_OR_lt_1)
})

# Tariq (2018) comparison
tariq <- tibble(
  study = c("Baxter 2008","Delaney 2007","Dial 2008","Doernberg 2012","Kuntz 2011","Tartof 2015"),
  yi  = c(-0.8916, -0.1054, 0.0953, -0.3147, -0.0619, -0.6931),
  sei = c( 0.2324,  0.2999, 1.2234,  0.1353,  0.3990,  0.1139))
dl <- rma(yi = tariq$yi, sei = tariq$sei, method = "DL")
bm_tariq  <- summ(bayesmeta(tariq$yi, tariq$sei,
                            mu.prior.mean = 0, mu.prior.sd = 1, tau.prior = hn))
tariq_ids <- c("Baxter2008","Delaney2007","Dial2008","Doernberg2012","Kuntz2011","Tartof2015")
new8 <- prim_abx |> filter(!study_id %in% tariq_ids)
bm_bridge <- summ(bayesmeta(c(tariq$yi, new8$yi), c(tariq$sei, new8$sei),
                            mu.prior.mean = 0, mu.prior.sd = 1, tau.prior = hn))
comp <- bind_rows(
  tibble(analysis = "Tariq 2018, original (DL frequentist)", k = 6,
         OR = exp(coef(dl)), OR_lo = exp(dl$ci.lb), OR_hi = exp(dl$ci.ub)),
  bm_tariq  |> transmute(analysis = "Tariq studies, our Bayesian model", k = 6, OR, OR_lo, OR_hi),
  bm_bridge |> transmute(analysis = "Tariq studies + 8 new studies", k = 14, OR, OR_lo, OR_hi),
  getp("primary") |> as_tibble() |>
    transmute(analysis = "This review, primary (Bayesian)", k = 11, OR, OR_lo, OR_hi))

# Care-context meta-regression
Xc <- model.matrix(~ 0 + care_context, data = prim_abx); colnames(Xc) <- c("CA","HA","mixed")
mr <- bmr(y = prim_abx$yi, sigma = prim_abx$sei, labels = prim_abx$reference, X = Xc,
          tau.prior = hn, beta.prior.mean = c(0,0,0), beta.prior.sd = c(1,1,1))
ctx <- tibble(care_context = c("CA","HA","mixed"),
  k     = as.integer(colSums(Xc)),
  OR    = exp(mr$summary["median",    c("CA","HA","mixed")]),
  OR_lo = exp(mr$summary["95% lower", c("CA","HA","mixed")]),
  OR_hi = exp(mr$summary["95% upper", c("CA","HA","mixed")]))
Xc20 <- model.matrix(~ 0 + care_context, data = prim); colnames(Xc20) <- c("CA","HA","mixed")
mr20 <- bmr(y = prim$yi, sigma = prim$sei, labels = prim$reference, X = Xc20,
            tau.prior = hn, beta.prior.mean = c(0,0,0), beta.prior.sd = c(1,1,1))
ctx20 <- tibble(care_context = c("CA","HA","mixed"),
  k     = as.integer(colSums(Xc20)),
  OR    = exp(mr20$summary["median",    c("CA","HA","mixed")]),
  OR_lo = exp(mr20$summary["95% lower", c("CA","HA","mixed")]),
  OR_hi = exp(mr20$summary["95% upper", c("CA","HA","mixed")]))

# brms fit (precomputed)
library(brms)
bfit <- readRDS("brms_fit_primary.rds")

# JAMA-style theme and palette
jama_navy <- "#2C4A63"; jama_blue <- "#3B6E9C"; jama_gray <- "#5A6B7B"; jama_band <- "#CBD8E3"
theme_jama <- function(base_size = 12) {
  theme_classic(base_size = base_size) +
    theme(text = element_text(colour = "#1A1A1A"),
          axis.line = element_line(colour = "#4D4D4D", linewidth = 0.4),
          axis.ticks = element_line(colour = "#4D4D4D", linewidth = 0.4),
          panel.grid.major.x = element_line(colour = "#EAEDF0", linewidth = 0.3),
          plot.title = element_text(face = "bold", size = rel(1.02)),
          plot.subtitle = element_text(colour = "#4D4D4D", size = rel(0.9)),
          legend.position = "top", legend.title = element_blank())
}

save_fig <- function(plot, name, width, height) {
  ggsave(file.path("figures", name), plot, width = width, height = height,
         dpi = 300, bg = "white")
}

# ---- Figure 1: forest plot (fig-forest, 8 x 5.2) ----
pooled <- getp("primary")
fit_prim <- bayesmeta(prim_abx$yi, prim_abx$sei, labels = prim_abx$reference,
                      mu.prior.mean = 0, mu.prior.sd = 1, tau.prior = hn)
th  <- fit_prim$theta
ord <- prim_abx |> arrange(exp(yi)) |> pull(reference)
fdf <- bind_rows(
  prim_abx |> transmute(study = reference, type = "Observed (study estimate)",
                        OR = exp(yi), lo = exp(yi - 1.96*sei), hi = exp(yi + 1.96*sei)),
  tibble(study = colnames(th), type = "Bayesian posterior (shrinkage)",
         OR = exp(th["median",]), lo = exp(th["95% lower",]), hi = exp(th["95% upper",]))
) |> mutate(study = factor(study, levels = ord),
            type = factor(type, levels = c("Observed (study estimate)",
                                           "Bayesian posterior (shrinkage)")))

priors_v <- tibble(
  label = factor(c("Sceptical prior", "Literature-informed prior"),
                 levels = c("Sceptical prior", "Literature-informed prior")),
  OR = c(res_abx$OR[res_abx$prior == "sceptical"], res_abx$OR[res_abx$prior == "literature"]))
sens_lo <- min(priors_v$OR, pooled$OR); sens_hi <- max(priors_v$OR, pooled$OR)

fig1 <- ggplot(fdf, aes(OR, study, colour = type)) +
  annotate("rect", xmin = sens_lo, xmax = sens_hi, ymin = -Inf, ymax = Inf,
           fill = jama_navy, alpha = 0.06) +
  annotate("rect", xmin = pooled$OR_lo, xmax = pooled$OR_hi, ymin = -Inf, ymax = Inf,
           fill = jama_band, alpha = 0.5) +
  geom_vline(xintercept = 1, linetype = "dashed", colour = "#4D4D4D", linewidth = 0.4) +
  geom_vline(xintercept = pooled$OR, colour = jama_navy, linewidth = 0.7) +
  geom_vline(data = priors_v, aes(xintercept = OR, linetype = label),
             colour = jama_navy, linewidth = 0.5) +
  geom_pointrange(aes(xmin = lo, xmax = hi), position = position_dodge(width = 0.6), size = 0.4) +
  scale_colour_manual(values = c("Observed (study estimate)" = jama_gray,
                                 "Bayesian posterior (shrinkage)" = jama_blue)) +
  scale_linetype_manual(values = c("Sceptical prior" = "dotted",
                                   "Literature-informed prior" = "longdash")) +
  scale_x_log10(breaks = c(0.1, 0.25, 0.5, 1, 2, 4, 10)) +
  labs(x = "Odds ratio (log scale)", y = NULL, linetype = "Pooled OR under prior") +
  guides(colour = guide_legend(order = 1), linetype = guide_legend(order = 2)) +
  theme_jama() + theme(legend.box = "vertical", legend.spacing.y = unit(1, "pt"))
save_fig(fig1, "fig1_forest.png", 8, 5.2)

# ---- Figure 2: MCMC trace (fig-trace, 8 x 4) ----
library(bayesplot)
fig2 <- mcmc_trace(bfit, pars = c("b_Intercept", "sd_study_id__Intercept"))
save_fig(fig2, "fig2_trace.png", 8, 4)

# ---- Figure 3: funnel plot (fig-funnel, 7 x 5.5; base graphics) ----
png(file.path("figures", "fig3_funnel.png"), width = 7, height = 5.5,
    units = "in", res = 300, bg = "white")
funnel(rma_abx, level = c(90, 95, 99),
       shade = c("white", "#D7E0E8", "#B4C6D6"),
       refline = 0, col = jama_navy, bg = jama_blue,
       legend = TRUE, xlab = "Log odds ratio")
dev.off()

# ---- Figure 4: leave-one-out (fig-loo, 8 x 5) ----
lp <- getp("primary")
fig4 <- loo |> arrange(OR) |> mutate(dropped = factor(dropped, levels = dropped)) |>
  ggplot(aes(OR, dropped)) +
  annotate("rect", xmin = lp$OR_lo, xmax = lp$OR_hi, ymin = -Inf, ymax = Inf,
           fill = jama_band, alpha = 0.5) +
  geom_vline(xintercept = 1, linetype = "dashed", colour = "#4D4D4D", linewidth = 0.4) +
  geom_vline(xintercept = lp$OR, colour = jama_navy, linewidth = 0.7) +
  geom_pointrange(aes(xmin = OR_lo, xmax = OR_hi), colour = jama_gray, size = 0.4) +
  scale_x_log10(breaks = c(0.5, 0.7, 1, 1.3)) +
  labs(x = "Pooled OR after removing the study (log scale)", y = "Study removed") +
  theme_jama()
save_fig(fig4, "fig4_leave_one_out.png", 8, 5)

# ---- Figure 5: doxycycline-only (fig-doxy, 7.5 x 4) ----
D <- as.list(res_sub[res_sub$analysis == "doxycycline", ])
doxy_studies <- prim_abx |>
  dplyr::filter(exposure_class == "doxycycline") |>
  transmute(label = reference, type = "Doxycycline study (observed)",
            OR = exp(yi), OR_lo = exp(yi - 1.96 * sei), OR_hi = exp(yi + 1.96 * sei))
pooled_rows <- tibble(
  label = c("Doxycycline only (pooled, k = 6)", "All tetracyclines (pooled, k = 11)"),
  type  = "Pooled estimate",
  OR    = c(D$OR, P$OR), OR_lo = c(D$OR_lo, P$OR_lo), OR_hi = c(D$OR_hi, P$OR_hi))
lev <- c("All tetracyclines (pooled, k = 11)", "Doxycycline only (pooled, k = 6)",
         doxy_studies |> arrange(desc(OR)) |> pull(label))
fig5 <- bind_rows(doxy_studies, pooled_rows) |>
  mutate(label = factor(label, levels = lev),
         type  = factor(type, levels = c("Doxycycline study (observed)", "Pooled estimate"))) |>
  ggplot(aes(OR, label, colour = type)) +
  annotate("rect", xmin = D$OR_lo, xmax = D$OR_hi, ymin = -Inf, ymax = Inf,
           fill = jama_band, alpha = 0.4) +
  geom_vline(xintercept = 1, linetype = "dashed", colour = "#4D4D4D", linewidth = 0.4) +
  geom_pointrange(aes(xmin = OR_lo, xmax = OR_hi), size = 0.45) +
  geom_text(aes(label = sprintf("%.2f (%.2f-%.2f)", OR, OR_lo, OR_hi)),
            vjust = -1, size = 3.2, colour = "#1A1A1A") +
  scale_colour_manual(values = c("Doxycycline study (observed)" = jama_gray,
                                 "Pooled estimate" = jama_navy)) +
  scale_x_log10(breaks = c(0.1, 0.25, 0.5, 1, 2, 4)) +
  labs(x = "Odds ratio (log scale)", y = NULL, colour = NULL) +
  theme_jama()
save_fig(fig5, "fig5_doxycycline.png", 7.5, 4)

# ---- Figure 6: care-context meta-regression (fig-metareg, 7.5 x 3.4) ----
fig6 <- bind_rows(ctx |> mutate(set = "Primary (k=11)"),
                  ctx20 |> mutate(set = "Sensitivity (k=20)")) |>
  mutate(care_context = factor(care_context, levels = c("mixed","HA","CA")),
         set = factor(set, levels = c("Primary (k=11)","Sensitivity (k=20)"))) |>
  ggplot(aes(OR, care_context, colour = set)) +
  geom_vline(xintercept = 1, linetype = "dashed", colour = "#4D4D4D", linewidth = 0.4) +
  geom_pointrange(aes(xmin = OR_lo, xmax = OR_hi),
                  position = position_dodge(width = 0.5), size = 0.45) +
  scale_colour_manual(values = c("Primary (k=11)" = jama_blue,
                                 "Sensitivity (k=20)" = jama_gray)) +
  scale_x_log10(breaks = c(0.3, 0.5, 0.8, 1, 1.5, 2)) +
  labs(x = "Odds ratio (log scale)", y = "Care context") +
  theme_jama()
save_fig(fig6, "fig6_care_context.png", 7.5, 3.4)

# ---- Figure 7: Tariq comparison (fig-tariq, 8 x 3.2) ----
fig7 <- comp |> mutate(analysis = factor(analysis, levels = rev(analysis))) |>
  ggplot(aes(OR, analysis)) +
  geom_vline(xintercept = 1, linetype = "dashed", colour = "#4D4D4D", linewidth = 0.4) +
  geom_pointrange(aes(xmin = OR_lo, xmax = OR_hi), colour = jama_navy, size = 0.5) +
  geom_text(aes(label = sprintf("%.2f (%.2f-%.2f)", OR, OR_lo, OR_hi)),
            vjust = -1, size = 3.2, colour = "#1A1A1A") +
  scale_x_log10(breaks = c(0.4, 0.5, 0.6, 0.8, 1, 1.2)) +
  labs(x = "Pooled OR (log scale)", y = NULL) +
  theme_jama()
save_fig(fig7, "fig7_tariq_comparison.png", 8, 3.2)

message("Done: ", paste(list.files("figures", pattern = "\\.png$"), collapse = ", "))
