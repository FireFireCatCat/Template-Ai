# Article class for The Canadian Journal of Statistics

The package **cjs-rcs-article** provides the document class and
bibliographic styles to typeset articles for [The Canadian Journal of
Statistics](https://ssc.ca/en/publications/canadian-journal-statistics).
The package also contains the official *Author guidelines for The
Canadian Journal of Statistics*.

The class relies on modern tools, such as 
the class [memoir](https://ctan.org/pkg/memoir), 
the fonts [STIX Two](https://ctan.org/pkg/stix2-otf)
and [Fira](https://ctan.org/pkg/fira), 
and the package [babel](https://ctan.org/pkg/babel). 
To take full advantage of its characteristics, we recommend that you 
compile with LuaLaTeX. The class remains nonetheless largely
compatible with the traditional engine pdfLaTeX.

## Licence

LaTeX Project Public License, version 1.3c or (at your option) any
later version. The documentation is also licensed under CC BY-SA 4.0
International.

## Version

2.0 (2026-03-05)

## Maintainer

Vincent Goulet <vincent.goulet@act.ulaval.ca> for the Statistical
Society of Canada

## Home page and repository

Project web site: https://cjs-rcs.gitlab.io  
Source code repository: https://gitlab.com/cjs-rcs/cjs-rcs-article

## Contents

- `cjs-rcs-article.ins`: installation script for the class,
  bibliographic styles and documentation; see below;
- `cjs-rcs-article.dtx`: source code of the class, with documentation;
- `cjs-rcs-authguide.dtx`: source code of the author guidelines;
- `cjs-rcs-merlin.mbs`: master bibliographic style;
- `cjs-rcs-english.mbs`: langage definition file for English;
- `cjs-rcs-french.mbs`: langage definition file for French;
- `cjs-rcs-article.dbj`: driver file for the document class;
- `cjs-rcs-authguide.dbj`: driver file for the author guidelines;
- `cjs-rcs-bst-en.dbj`: driver file for the English bibliographic
  style;
- `cjs-rcs-bst-fr.dbj`: driver file for the French bibliographic
  style;
- `cjs-rcs-article.pdf`: English documentation of the class (including
  the implementation details and version history);
- `cjs-rcs-article-fr.pdf`: French documentation of the class (without
  the implementation details and version history);
- `cjs-rcs-authguide.pdf`: English author guidelines;
- `cjs-rcs-authguide-fr.pdf`: French author guidelines;
- `cjs-rcs-figure.pdf`: sample figure for the author guidelines;
- `cjs-rcs-merlin.pdf`: documentation of the master bibliographic
  style;
- `cjs-templates.tex`: template for an article in English;
- `rcs-gabarit.tex`: template for an article in French;
- `README.md`: this file.

## Installation

The package **cjs-rcs-article** is distributed through the
Comprehensive TeX Archive Network (CTAN) and it is part of the
standard TeX distributions. Therefore, we strongly recommend using
the package manager of your distribution to install or update the
package.

TeX experts may generate the essential files of the class by running
the file `cjs-rcs-article.ins` through LaTeX:

    latex cjs-rcs-article.ins

The compilation will create the class itself (`cjs-rcs-article.cls`),
the bibliographic styles (`cjs-rcs-en.bst`, `cjs-rcs-fr.bst`), and the
templates for articles in English and French (`cjs-template.tex`,
`rcs-gabarit.tex`).

## Documentation

The documents `cjs-rcs-article.pdf` and `cjs-rcs-article-fr.pdf`
provide the complete documentation of the class and the bibliographic
styles. After running the file `cjs-rcs-article.ins` through LaTeX as
explained above, you may recreate these documents from the file
`cjs-rcs-article.dtx` as follows:

    lualatex cjs-rcs-article.dtx
    makeindex -s gglo.ist -o cjs-rcs-article.gls cjs-rcs-article.glo
    lualatex cjs-rcs-article.dtx
    lualatex cjs-rcs-article.dtx
    lualatex cjs-rcs-article-fr.tex
    lualatex cjs-rcs-article-fr.tex
    lualatex cjs-rcs-article-fr.tex

Similarly, `cjs-rcs-authguide.pdf` and `cjs-rcs-authguide-fr.pdf`
contain the author guidelines. You may recreate these documents from
the file `cjs-rcs-authguide.dtx` as follows:

    lualatex cjs-rcs-authguide.dtx
    makeindex -s gglo.ist -o cjs-rcs-authguide.gls cjs-rcs-authguide.glo
    lualatex cjs-rcs-authguide.dtx
    lualatex cjs-rcs-authguide.dtx
    lualatex cjs-rcs-authguide-fr.tex
    lualatex cjs-rcs-authguide-fr.tex
    lualatex cjs-rcs-authguide-fr.tex

The file `cjs-rcs-merlin.pdf` contains documentation for the creation
and generation of the bibliographic styles. It should be of interest
to experts and developers only. To recreate the document, compile
`cjs-rcs-merlin.mbs` as follows:

    lualatex cjs-rcs-merlin.mbs
    makeindex -s gglo.ist -o cjs-rcs-merlin.gls cjs-rcs-merlin.glo
    lualatex cjs-rcs-merlin.mbs
	lualatex cjs-rcs-merlin.mbs

## Version history

The version history of the class appears in `cjs-article.pdf`. The
version history of the author guidelines appears in
`cjs-rcs-authguide.pdf`. The version history of the bibliographic
styles appears in `cjs-rcs-merlin.pdf`.

## Comments or suggestions

The [project repository](https://gitlab.com/cjs-rcs/cjs-rcs-article)
in GitLab is the best place to report bugs or propose improvements to
the project.

======================================================================

# Classe pour les articles de La revue canadienne de statistique

Le paquetage **cjs-rcs-article** fournit la classe et les styles de
bibliographie pour la composition d'articles scientifiques destinés à
[La revue canadienne de statistique](https://ssc.ca/fr/publications/revue-canadienne-statistique).
Le paquetage contient également les *Directives pour les auteurs de La
revue canadienne de statistique*.

La classe repose sur des outils modernes, tels que 
la classe [memoir](https://ctan.org/pkg/memoir), 
les polices [STIX Two](https://ctan.org/pkg/stix2-otf) 
et [Fira](https://ctan.org/pkg/fira), 
ainsi que le paquetage [babel](https://ctan.org/pkg/babel). 
Pour tirer pleinement profit des caractéristiques de la classe, nous
recommandons de compiler avec LuaLaTeX. La classe demeure néanmoins en
grande partie compatible avec le moteur pdfLaTeX.

## Licence

LaTeX Project Public License, version 1.3c ou (à votre choix) toute
version ultérieure. La documentation est également publiée sous 
licence CC BY-SA 4.0 International.

## Version

2.0 (2026-03-05)

## Mainteneur

Vincent Goulet <vincent.goulet@act.ulaval.ca> pour la Société
canadienne de statistique

## Site web et dépôt

Site web du projet: https://cjs-rcs.gitlab.io  
Dépôt du code source: https://gitlab.com/cjs-rcs/cjs-rcs-article

## Contenu du paquetage

- `cjs-rcs-article.ins`: procédure d'installation de la classe et des
  styles de bibliographie; voir ci-dessous;
- `cjs-rcs-article.dtx`: fichier source documenté de la classe;
- `cjs-rcs-authguide.dtx`: fichier source des directives pour les
  auteurs;
- `cjs-rcs-merlin.mbs`: fichier maitre de styles bibliographiques;
- `cjs-rcs-english.mbs`: fichier de localisation pour l'anglais;
- `cjs-rcs-french.mbs`: fichier de localisation pour le français;
- `cjs-rcs-article.dbj`: script de génération de la classe;
- `cjs-rcs-authguide.dbj`: script de génération des directives pour
  les auteurs;
- `cjs-rcs-bst-en.dbj`: script de génération du style de bibliographie
   anglais;
- `cjs-rcs-bst-fr.dbj`: script de génération du style de bibliographie
  français;
- `cjs-rcs-article.pdf`: documentation anglaise de la classe (incluant
  la mise en œuvre et l'historique des versions);
- `cjs-rcs-article-fr.pdf`: documentation française de la classe (sans
  la mise en œuvre et l'historique des versions);
- `cjs-rcs-authguide.pdf`: version anglaise des directives pour les
  auteurs;
- `cjs-rcs-authguide-fr.pdf`: version française des directives pour
  les auteurs;
- `cjs-rcs-figure.pdf`: exemple de figure pour les directives pour les
  auteurs;
- `cjs-rcs-merlin.pdf`: documentation sur la création des styles de
  bibliographie;
- `cjs-templates.tex`: gabarit pour un article en anglais;
- `rcs-gabarit.tex`: gabarit pour un article en français;
- `README.md`: le présent fichier.

## Installation

Le paquetage **cjs-rcs-article** est distribué via le réseau de sites
Comprehensive TeX Archive Network (CTAN) et il fait partie des
distributions TeX standards. Par conséquent, nous recommandons
fortement d'installer ou de mettre à jour le paquetage à l'aide du
gestionnaire de paquetages de votre distribution.

Les experts TeX peuvent générer les fichiers essentiels de la classe
en compilant le fichier `cjs-rcs-article.ins` avec LaTeX:

    latex cjs-rcs-article.ins

La compilation créera le fichier de la classe elle-même
(`cjs-rcs-article.cls`), les styles de bibliographie
(`cjs-rcs-en.bst`, `cjs-rcs-fr.bst`), ainsi que les gabarits pour des
articles en français et en anglais (`rcs-gabarit.tex`,
`cjs-template.tex`).

## Documentation

Les documents `cjs-rcs-article.pdf` et `cjs-rcs-article-fr.pdf`
fournissent la documentation complète de la classe et des styles de
bibliographie. Après avoir compilé le fichier `cjs-rcs-article.ins`
avec LaTeX tel qu'expliqué ci-dessus, vous pouvez recréer les
documents à partir du fichier `cjs-rcs-article.dtx` à l'aide des
commandes suivantes:

    lualatex cjs-rcs-article.dtx
    makeindex -s gglo.ist -o cjs-rcs-article.gls cjs-rcs-article.glo
    lualatex cjs-rcs-article.dtx
    lualatex cjs-rcs-article.dtx
    lualatex cjs-rcs-article-fr.tex
    lualatex cjs-rcs-article-fr.tex
    lualatex cjs-rcs-article-fr.tex

Les documents `cjs-rcs-authguide.pdf` et `cjs-rcs-authguide-fr.pdf`
contiennent quant à eux les directives pour les auteurs. Vous pouvez
les recréer de manière similaire à partir de `cjs-rcs-authguide.dtx`
avec les commandes suivantes:

    lualatex cjs-rcs-authguide.dtx
    makeindex -s gglo.ist -o cjs-rcs-authguide.gls cjs-rcs-authguide.glo
    lualatex cjs-rcs-authguide.dtx
    lualatex cjs-rcs-authguide.dtx
    lualatex cjs-rcs-authguide-fr.tex
    lualatex cjs-rcs-authguide-fr.tex
    lualatex cjs-rcs-authguide-fr.tex

Enfin, le fichier `cjs-rcs-merlin.pdf` contient la documentation (en
anglais) sur la création des styles de bibliographie. Celle-ci n'est
susceptible d'intéresser que les experts et les développeurs. Pour
recréer le document, compilez `cjs-rcs-merlin.mbs` ainsi:

    lualatex cjs-rcs-merlin.mbs
    makeindex -s gglo.ist -o cjs-rcs-merlin.gls cjs-rcs-merlin.glo
    lualatex cjs-rcs-merlin.mbs
    lualatex cjs-rcs-merlin.mbs

## Historique des versions

L'historique des versions est fourni uniquement dans les versions
anglaises des documents. Celui de la classe se trouve dans
`cjs-rcs-article.pdf`, celui des directives pour les auteurs dans
`cjs-rcs-authguide.pdf` et celui des styles de bibliographie, dans
`cjs-rcs-merlin.pdf`.

## Commentaires et suggestions

Le [dépôt du projet](https://gitlab.com/cjs-rcs/cjs-rcs-article) dans
GitLab demeure le meilleur endroit pour rapporter des bogues ou pour
proposer des améliorations au projet.
