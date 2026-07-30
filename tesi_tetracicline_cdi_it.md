# Tetracicline e rischio di infezione da *Clostridioides difficile*
## Sintesi delle evidenze e proposta di tesi per una meta-analisi bayesiana

*Documento preparato per una tesi di laurea in Medicina e Chirurgia — Malattie Infettive*

---

## Parte 1 — Sintesi delle evidenze

### Il quesito clinico
La scelta dell'antibiotico in pazienti ad alto rischio di infezione da *Clostridioides difficile* (ICD) rimane un dilemma della pratica clinica. Da tempo si osserva che le tetracicline — in particolare la doxiciclina — potrebbero associarsi a un rischio di ICD **inferiore** rispetto ad altre classi antibiotiche, ma i risultati dei singoli studi sono in parte discordanti.

### Che cosa mostrano i dati
Le evidenze provengono da tre filoni convergenti:

1. **Meta-analisi per classe antibiotica.** In due meta-analisi indipendenti sull'ICD di comunità (2013), le tetracicline sono l'unica classe che **non** aumenta il rischio (OR ~0,91–0,92), mentre clindamicina, fluorochinoloni e cefalosporine mostrano gli aumenti maggiori (Figura 1a).
2. **Meta-analisi dedicata (Tariq et al., *Clinical Infectious Diseases*, 2018).** Sei studi (4 caso-controllo, 2 di coorte, arruolamento 1993–2012) mostrano che le tetracicline si associano a una **riduzione** del rischio di ICD rispetto ad altri antibiotici: OR aggregato **0,62** (IC 95% 0,47–0,81; p < 0,001); nel sottogruppo doxiciclina OR **0,55** (IC 95% 0,40–0,75) (Figura 1b). L'eterogeneità è rilevante (I² = 53%).
3. **Dato recente più ampio (VA, 2024).** In pazienti con polmonite acquisita in comunità, la doxiciclina rispetto all'azitromicina ha ridotto il rischio di ICD del ~17% (e del ~45% nei pazienti con pregressa ICD).

### Plausibilità biologica
Le tetracicline perturbano il microbiota anaerobio del colon in misura minore rispetto a clindamicina, cefalosporine e fluorochinoloni; inoltre doxiciclina e tigeciclina possono ridurre la produzione di tossine e possiedono proprietà anti-infiammatorie indipendenti dall'attività antibatterica.

### Limiti (fondamentali)
- **Tutte le evidenze umane sono osservazionali** — nessun RCT. Il confondimento da indicazione è la minaccia principale.
- «Rischio inferiore», non «terapia protettiva»: l'evidenza supporta la **preferenza** per una tetraciclina quando clinicamente appropriata (argomento di *antimicrobial stewardship*), non un uso profilattico o terapeutico contro l'ICD.
- Eterogeneità non trascurabile (I² ~53%).
- Resistenza alle tetracicline comune negli isolati clinici di *C. difficile* (spesso via elemento mobile *tetM*) — osservazione ecologica, distinta dal rischio a livello di paziente.

![Figura 1]({{artifact:cf1df173-1070-42c9-add1-614e8b1cc3e5}})

**Figura 1.** *(a)* Rischio di ICD di comunità per classe antibiotica (odds ratio rispetto a nessuna esposizione; le tetracicline in rosso sono l'unica classe compatibile con l'assenza di aumento del rischio). *(b)* Effetto aggregato delle tetracicline rispetto ad altri antibiotici (Tariq et al. 2018). Scala logaritmica; la linea tratteggiata indica OR = 1.

---

## Parte 2 — Proposta di tesi: meta-analisi bayesiana

### Titolo proposto
**«Tetracicline e rischio di infezione da *Clostridioides difficile*: una meta-analisi bayesiana a effetti casuali con analisi di sensibilità sui prior»**

### Razionale metodologico
La meta-analisi frequentista esistente (Tariq 2018) presenta due caratteristiche che rendono l'approccio bayesiano particolarmente adatto:
- **poche stime (k = 6) ed eterogeneità marcata (I² ≈ 53%)**: con pochi studi, la stima frequentista della varianza tra-studi (τ²) è instabile e gli intervalli di confidenza tendono a essere troppo stretti. Il modello bayesiano gerarchico stima τ² con la sua piena incertezza;
- **natura osservazionale con potenziale confondimento**: i *prior* permettono di incorporare esplicitamente lo scetticismo verso stime osservazionali e di quantificare quanto le conclusioni dipendano da tale scetticismo.

### Obiettivi
1. **Primario:** stimare l'OR aggregato (con intervallo di credibilità al 95%) dell'associazione tetracicline–ICD tramite un modello gerarchico bayesiano a effetti casuali.
2. **Secondari:** (a) stimare τ² e la distribuzione predittiva per un nuovo studio; (b) calcolare la **probabilità a posteriori** che OR < 1 e che OR < 0,80 (soglia di rilevanza clinica); (c) analisi di sottogruppo doxiciclina; (d) analisi di sensibilità sui *prior*.

### Domanda e disegno (PECO)
- **P** — pazienti esposti ad antibiotici sistemici;
- **E** — esposizione a una tetraciclina (doxiciclina, minociclina, tigeciclina);
- **C** — esposizione ad altri antibiotici / nessuna tetraciclina;
- **O** — ICD incidente (diagnosi microbiologica/clinica).
- **Disegno:** revisione sistematica + meta-analisi bayesiana, condotta secondo **PRISMA 2020**; protocollo pre-registrato su **PROSPERO**.

### Metodi (piano di lavoro per lo studente)

**1. Ricerca e selezione.** Stringhe di ricerca su PubMed/MEDLINE, Embase, Web of Science e Cochrane, dal 2016 (fine ricerca di Tariq) a oggi, per aggiornare il corpus. Due revisori indipendenti, risoluzione dei conflitti, diagramma di flusso PRISMA. Qualità con **Newcastle-Ottawa Scale**.

**2. Estrazione dati.** Per ogni studio: disegno, sede, popolazione, numerosità, definizione di ICD, OR/HR aggiustato e IC, covariate di aggiustamento. Conversione di tutte le stime su scala **log(OR)** con relativo errore standard.

**3. Modello statistico (effetti casuali, gerarchico).**
Per lo studio *i*, con stima osservata *yᵢ* = log(ORᵢ) ed errore standard *sᵢ*:

    yᵢ  ~  Normal(θᵢ, sᵢ²)              (verosimiglianza, sᵢ noto)
    θᵢ  ~  Normal(μ, τ²)                (effetti casuali tra studi)
    μ   ~  Normal(0, 1²)                (prior sull'effetto aggregato — vedi sotto)
    τ   ~  Half-Normal(0, 0,5)          (prior debolmente informativo sull'eterogeneità)

- **μ** è l'effetto aggregato su scala log(OR); si riporta exp(μ) come OR.
- **τ** è la deviazione standard tra studi; un *half-Normal* o *half-Cauchy* è preferibile al prior uniforme quando k è piccolo.

**4. Analisi di sensibilità sui prior (cuore metodologico della tesi).** Confrontare almeno tre prior su μ:
- **non informativo / vago:** Normal(0, 10²);
- **scettico:** Normal(0, 0,35²) — centra l'aspettativa sull'assenza di effetto, penalizza effetti grandi;
- **entusiasta / informato dalla letteratura:** Normal(log 0,62, ~0,10²), centrato sulla stima di Tariq.
Mostrare come la stima a posteriori e P(OR<1) variano tra i prior (robustezza).

**5. Stima computazionale.** MCMC (Hamiltonian Monte Carlo). Strumenti consigliati, tutti gratuiti:
- **R** con `brms` o `rjags`/`R2jags`, oppure il pacchetto `bayesmeta` (progettato esattamente per questo modello e semplicissimo da usare per una tesi);
- in alternativa **Python** con `PyMC`.
Diagnostica di convergenza: R-hat < 1,01, ESS adeguato, trace plot.

**6. Output e presentazione.**
- Forest plot bayesiano con intervalli di credibilità e stima aggregata (come Figura 1b);
- densità a posteriori di μ (come Figura 2a) e stima di τ;
- tabella di P(OR<1) e P(OR<0,80) per ciascun prior;
- **distribuzione predittiva** per un nuovo studio;
- confronto numerico con la stima frequentista di Tariq.

![Figura 2]({{artifact:f18699a3-3da6-4a95-bccb-1097376c73e3}})

**Figura 2.** Concetti chiave del metodo. *(a)* Aggiornamento bayesiano: il *prior* scettico (blu) combinato con la verosimiglianza dei dati (grigio) produce la distribuzione a posteriori (rosso) dell'effetto aggregato. *(b)* Modello gerarchico: le stime dei singoli studi (grigio) vengono «contratte» (*shrinkage*) verso l'effetto comune (linea rossa) in misura inversamente proporzionale alla loro precisione. **I valori a livello di studio nel pannello (b) sono illustrativi**, a scopo didattico.

### Perché è una buona tesi
- **Fattibile** in pochi mesi: dataset piccolo (k ≈ 6–10 studi), modello standard, software gratuito e ben documentato.
- **Rigorosa e didattica:** insegna revisione sistematica PRISMA, inferenza bayesiana, MCMC e comunicazione dell'incertezza.
- **Clinicamente rilevante:** traduce l'evidenza in una probabilità direttamente interpretabile («qual è la probabilità che le tetracicline riducano davvero il rischio di ICD?»), utile per la *stewardship*.
- **Originale rispetto alla letteratura:** nessuna sintesi bayesiana pubblicata su questo specifico quesito; l'aggiornamento del corpus post-2016 aggiunge valore.

### Rischi e mitigazioni
- *Pochi studi nuovi dal 2016* → la tesi resta valida come **ri-analisi bayesiana** del corpus esistente più eventuale aggiornamento.
- *Eterogeneità nelle definizioni di esposizione/esito* → analisi di sottogruppo e meta-regressione (se k lo consente) o discussione qualitativa.
- *Confondimento residuo (dati osservazionali)* → dichiarato esplicitamente; il prior scettico serve anche a questo.

### Cronoprogramma indicativo (6 mesi)
| Mese | Attività |
|---|---|
| 1 | Protocollo, registrazione PROSPERO, stringhe di ricerca |
| 2 | Screening, selezione, valutazione qualità (2 revisori) |
| 3 | Estrazione dati, costruzione dataset log(OR) |
| 4 | Implementazione modello bayesiano, diagnostica MCMC |
| 5 | Analisi di sensibilità sui prior, figure |
| 6 | Stesura, discussione, revisione finale |

---

*Nota clinica: questo documento ha finalità di ricerca e didattiche. Le decisioni terapeutiche sui singoli pazienti spettano al medico curante con accesso al quadro clinico completo.*
