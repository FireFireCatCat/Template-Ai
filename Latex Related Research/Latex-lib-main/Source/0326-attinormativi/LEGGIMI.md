# attinormativi

Classe LaTeX per la composizione tipografica di atti normativi italiani:
regolamenti comunali, delibere, statuti, ordinanze e documenti analoghi.

Versione 1.2 — 25 maggio 2026  
Autore: Federico Gallo <gallofede75@gmail.com>  
Licenza: LPPL 1.3c (maintained)

---

## Descrizione

La classe attinormativi fornisce un framework tipografico completo per
gli atti normativi italiani. Gestisce la struttura gerarchica tipica di
tali documenti (libri, titoli, capi, sezioni, articoli, commi), il
frontespizio istituzionale, gli indici dedicati (articoli, allegati,
definizioni), la modalità bozza con note redazionali e l'integrazione
opzionale con il pacchetto cleveref per i riferimenti incrociati in
italiano.

A partire dalla versione 1.2 la classe supporta la produzione di PDF
conformi allo standard **PDF/UA-1** (ISO 14289-1) tramite l'opzione
accessible, in conformità alla Direttiva (UE) 2016/2102 recepita in
Italia con D.Lgs. 106/2018. Questa funzionalità richiede LuaLaTeX e
TeX Live 2023 o successivo; tutti gli altri motori e tutte le altre
funzionalità della classe rimangono disponibili senza restrizioni con
pdfLaTeX, XeLaTeX e LuaLaTeX.

La classe è costruita sopra la classe standard book.

---

## Contenuto del pacchetto

attinormativi.cls          File della classe
attinormativi.dtx          Sorgente documentato
attinormativi.ins          File di installazione
attinormativi-doc.pdf      Manuale della classe
attinormativi-esempi.tex   Esempio di utilizzo (sorgente)
attinormativi-esempi.pdf   Esempio di utilizzo (compilato)
README.md                  Leggimi in inglese
LEGGIMI.md                 Questo file
LICENSE                    Testo della licenza LPPL 1.3c

---

## Requisiti

### Funzionalità standard

TeX Live 2020 o successivo (o distribuzione MiKTeX equivalente).  
Motori supportati: **pdfLaTeX**, **XeLaTeX**, **LuaLaTeX**.

Pacchetti richiesti (tutti inclusi nelle distribuzioni standard):
iftex, tgtermes, tgheros, tgcursor (solo pdfLaTeX),
fontspec (solo XeLaTeX/LuaLaTeX), geometry, babel (con supporto
lingua italiana), microtype, xcolor, titlesec, chngcntr,
enumitem, hyperref.

Per pdfLaTeX sono inoltre necessari inputenc e fontenc, anch'essi
inclusi nel kernel di qualsiasi installazione standard.

Il pacchetto xparse è caricato automaticamente solo su installazioni
con kernel LaTeX antecedente al 1° ottobre 2020; sulle versioni
successive è superfluo in quanto i comandi corrispondenti sono nativi.

Il pacchetto opzionale cleveref abilita la formattazione automatica
in italiano dei riferimenti incrociati.

### Opzione accessible (PDF/UA-1)

L'opzione accessible richiede **tutti e tre** i seguenti prerequisiti:

- **LuaLaTeX** come motore di composizione. Con pdfLaTeX o XeLaTeX il
  tagging PDF/UA non è supportato nella forma completa dal kernel
  attuale: la classe emette un \ClassWarning e disattiva
  automaticamente il tagging; la compilazione prosegue senza errori
  fatali ma il PDF prodotto non è taggato.
- **TeX Live 2023 o successivo** (kernel LaTeX ≥ 2023-06-01), che
  include il framework di tagging automatico e il pacchetto tagpdf.
- **La dichiarazione \DocumentMetadata** inserita *prima* di
  \documentclass nel file .tex (vedere la sezione «Utilizzo con
  l'opzione accessible» più avanti). Se \DocumentMetadata è
  assente, la classe emette un \ClassWarning e disattiva
  automaticamente il tagging; anche in questo caso la compilazione
  prosegue senza errori fatali.

---

## Font

La classe utilizza la famiglia **TeX Gyre**, disponibile in qualsiasi
installazione standard di TeX Live e MiKTeX senza dipendenze aggiuntive.

- **Serif**: TeX Gyre Termes (clone di Times New Roman)
- **Sansserif**: TeX Gyre Heros (clone di Helvetica)
- **Monospaced**: TeX Gyre Cursor (clone di Courier)

Con **pdfLaTeX** vengono caricati i pacchetti tgtermes, tgheros e
tgcursor. Con **XeLaTeX** e **LuaLaTeX** i corrispondenti font
OpenType sono selezionati tramite fontspec.

---

## Installazione

### TeX Live e MiKTeX (caso normale)

La classe è distribuita tramite CTAN ed è inclusa in **TeX Live** e
**MiKTeX**. Se si usa una di queste distribuzioni non è necessario
copiare alcun file manualmente: è sufficiente aggiornare i pacchetti
con il gestore della propria distribuzione.

Con TeX Live (da terminale):

    tlmgr update attinormativi

Con MiKTeX: avviare il **MiKTeX Console**, selezionare
«Updates» e aggiornare il pacchetto attinormativi, oppure
eseguire da terminale:

    miktex packages update attinormativi

### Installazione locale a un singolo progetto

Per un uso occasionale è sufficiente copiare attinormativi.cls
nella stessa cartella del file .tex da compilare, senza modificare
la struttura TEXMF.

### Rigenerazione dal sorgente

Per rigenerare attinormativi.cls dal sorgente documentato:

    latex attinormativi.ins

---

## Utilizzo di base

latex
\documentclass[bozza, serif, simplex, 12pt]{attinormativi}

\autoritaatto{Comune di Esempiopoli}
\tipoatto{Regolamento}
\numeroatto{3}
\dataatto{17 maggio 2026}
\titoloatto{Regolamento per la gestione degli spazi pubblici}
\oggettoatto{Disciplina delle modalità di utilizzo e concessione degli spazi pubblici comunali}

\begin{document}
\frontespizioatto
\bozzainfo
\tableofcontents
\indicearticoli

\titolo{Disposizioni generali}

\articolo{Finalità e ambito di applicazione}[art:finalita]
\comma{Il presente regolamento disciplina le modalità di utilizzo
degli spazi pubblici di proprietà del Comune di Esempiopoli.}

\entrataInVigore{Il presente regolamento entra in vigore il giorno
successivo alla sua pubblicazione all'albo pretorio online.}

\end{document}


La documentazione completa è disponibile in attinormativi-doc.pdf.
Esempi di utilizzo sono in attinormativi-esempi.pdf.

---

## Utilizzo con l'opzione accessible

Per produrre un PDF conforme a PDF/UA-1 aggiungere la dichiarazione
\DocumentMetadata *prima* di \documentclass e includere l'opzione
accessible:

latex
\DocumentMetadata{
  pdfversion  = 1.7,
  pdfstandard = UA-1,
  lang        = it-IT,
}
\documentclass[accessible]{attinormativi}


Le opzioni standard della classe (bozza, serif, sansserif,
simplex, duplex, margini) sono compatibili con accessible.

La conformità del PDF prodotto può essere verificata con PAC 2024
(PDF Accessibility Checker, gratuito, Windows) o con Adobe Acrobat Pro
(Strumenti → Accessibilità → Verifica completa).

---

## Opzioni della classe

| Opzione        | Descrizione                                                          |
|----------------|----------------------------------------------------------------------|
| bozza        | Modalità bozza: le note redazionali diventano visibili               |
| accessible   | Tagging PDF/UA-1 — solo LuaLaTeX + TeX Live 2023+                    |
| serif        | TeX Gyre Termes — tutti i motori (predefinito)                       |
| sansserif    | TeX Gyre Heros — tutti i motori                                      |
| simplex      | Impaginazione solo fronte (predefinito); alias: oneside            |
| duplex       | Impaginazione fronte/retro con margini asimmetrici; alias: twoside |
| left=<dim>   | Sovrascrive il margine sinistro (default: 35 mm)                     |
| right=<dim>  | Sovrascrive il margine destro (default: 30 mm)                       |
| top=<dim>    | Sovrascrive il margine superiore (default: 25 mm)                    |
| bottom=<dim> | Sovrascrive il margine inferiore (default: 25 mm)                    |

---

## Flusso di compilazione

### Flusso standard (tutti i motori)

Per ottenere tutti gli indici correttamente popolati sono necessarie
almeno due compilazioni. Sostituire lualatex con pdflatex o
xelatex a seconda del motore scelto:

    lualatex documento.tex
    makeindex -s gind.ist documento.idx
    makeindex -s gglo.ist -o documento.gls documento.glo
    lualatex documento.tex
    lualatex documento.tex

### Flusso con l'opzione accessible (solo LuaLaTeX)

Con l'opzione accessible attiva occorre compilare esclusivamente con
LuaLaTeX. Non è necessario eseguire makeindex per gli indici
secondari (.art, .alg, .dfn), che si aggiornano automaticamente:

    lualatex documento.tex
    lualatex documento.tex
    lualatex documento.tex

### File ausiliari corrotti

Se la compilazione si interrompe in modo anomalo, il file .aux può
risultare troncato e la compilazione successiva produrrà l'errore:

    File ended while scanning use of \@writefile

La soluzione è eliminare tutti i file ausiliari (.aux, .toc,
.idx, .glo, .art, .alg, .dfn, .out) e ripartire da capo.

---

## Licenza

Questo lavoro può essere distribuito e/o modificato secondo i termini
della LaTeX Project Public License, versione 1.3c o successiva.

https://www.latex-project.org/lppl.txt

Questo lavoro ha lo stato LPPL maintained.  
Il Manutentore corrente è Federico Gallo <gallofede75@gmail.com>.

---

## Cronologia delle versioni

**v1.2 (25 maggio 2026)**  
Migrazione dei font dalla famiglia Latin Modern alla famiglia TeX Gyre:
TeX Gyre Termes (serif), TeX Gyre Heros (sansserif), TeX Gyre Cursor
(monospaced). Con pdfLaTeX vengono caricati i pacchetti tgtermes,
tgheros e tgcursor; con XeLaTeX e LuaLaTeX i corrispondenti font
OpenType tramite fontspec.  
Aggiunta opzione accessible per il tagging strutturale PDF/UA-1
tramite tagpdf e il framework di tagging del kernel LaTeX (richiede
LuaLaTeX + TeX Live 2023+). Tagging strutturato del frontespizio
(ruoli Title e P), dei commi (ruolo P), delle liste normative
(ruolo OL), dell'ambiente definizioni (ruoli DL/DT/DD),
degli ambienti preambolo e relazione (ruolo Sect), degli allegati
(ruoli Sect/Caption) e degli indici secondari (ruolo TOC). Le
note redazionali sono marcate come Artifact. La gerarchia strutturale
\libro–\articolo è mappata ai ruoli heading H1–H5.

**v1.1 (17 maggio 2026)**  
Prima versione stabile con font Latin Modern, opzione duplex,
opzioni di margine personalizzabili, alias \maketitle, supporto
cleveref con nomi italiani e varie correzioni tipografiche.

**v1.0 (8 maggio 2026)**  
Prima versione pubblica.
