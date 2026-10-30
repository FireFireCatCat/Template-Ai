# Journal des versions

## 1.1 — 2026-07-30

### Le programme de mathématiques, couvert de l'école au supérieur

- **Collège** : rédactions canoniques de Pythagore (calcul et réciproque),
  Thalès (calcul et réciproque), trigonométrie du triangle rectangle (côté
  et angle) ; moyenne (simple et pondérée), médiane, étendue, quartiles ;
  quatrième proportionnelle, tableaux de proportionnalité (vérifiés ou
  complétés), pourcentages, taux d'évolution, échelles, vitesse, distance,
  durée ; périmètres, aires et volumes de dix figures avec formule et pi
  exact ; conversions d'unités par décalage décimal exact ; fractions pas
  à pas, notation scientifique, critères de divisibilité justifiés,
  division euclidienne et PGCD entiers ; programmes de calcul (appliqués
  ou exprimés en fonction de x) ; transformations du plan (symétries
  axiale et centrale, translation, rotation, homothétie) avec coordonnées
  des images et tracé sur quadrillage.
- **Lycée** : convexité, asymptotes, équations trigonométriques ; produit
  scalaire, normes, angles, colinéarité, plans de l'espace ; graphes
  (tracé, matrice d'adjacence, dénombrement de chemins), puissances de
  matrices et état stable des chaînes de Markov ; équations
  diophantiennes par Bézout ; racines n-ièmes de l'unité ; intervalle de
  fluctuation et inégalité de Bienaymé-Tchebychev ; espérance, variance
  et écart type d'une loi posée en tableau.
- **Supérieur (CPGE)** : intégrales exactes et impropres, équivalents,
  séries numériques ; rang, noyau, image ; polynômes caractéristique et
  minimal, trigonalisation ; Gram-Schmidt et projeté orthogonal ;
  division euclidienne, PGCD et factorisation des polynômes formels dans
  R[X] ou C[X] ; fonctions de plusieurs variables (gradient, hessienne,
  dérivées partielles, points critiques avec leur nature) ; séries de
  Fourier, transformées de Laplace directe et inverse, wronskien.

### Organisation et qualité

- Les exemples suivent désormais quatre niveaux, portés par le suffixe du
  nom de fichier : 1 (langue), 2 (collège), 3 (lycée), 4 (supérieur),
  rangés dans le dossier `exemples/` avec leurs images.
- Préchargement parallèle des calculs étendu à toutes les nouvelles
  actions et cache disque des résultats (`_texecole-cache`) : les
  recompilations d'un document de calcul retombent au coût d'un document
  sans calcul.
- Chargement conditionnel des bibliothèques lourdes (pgfplots, tkz-tab,
  tabularray, poster) selon le contenu du document.
- Sources nettoyées, messages d'erreur en français de la classe.

## 1.0

Première publication : le langage, la syntaxe en prose française, les
deux moteurs de calcul (interne et SymPy), les objets (cadres, tableaux,
grilles, images, listes), les figures, les repères, les solides, les
diagrammes statistiques, les arbres de probabilité, les opérations
posées et la droite graduée.
