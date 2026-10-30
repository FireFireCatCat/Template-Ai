----------------------------------------------------------------
anima --- Class for creating slideshow with simple animations with TikZ
E-mail: adriano_gsgs@hotmail.com
Written by Adriano Gomes de Santana
Released under the LaTeX Project Public License v1.3c or later
See http://www.latex-project.org/lppl.txt
----------------------------------------------------------------

The idea for this package arose from noticing that including the |\pause| command from the |beamer| class within the |\foreach| loop command from the |tikz| package creates a sequence of frames, where each slide presents a step in the construction of the image. The purpose of the |anima| class is to provide macros that simplify the use of this effect for creating animated slide presentations.

Although the functionality of this class can be compared to the transition effects of the |beamer| class, it is not a dependency of the |anima| class. However, the class makes extensive use of the image creation language provided by the |tikz| package. Lastly, it is worth noting a comparison between this class and the |animate| package. The |animate| package can create embedded animations within the document, while the |anima| class produces an animation where each frame corresponds to a page of the document. This distinction highlights the different design goals of the |anima| class.

