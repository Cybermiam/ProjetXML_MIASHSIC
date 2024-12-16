-- TESTS VALIDATIONS (grilles valides et invalides) --
xmllint --schema validationgrille.xsd grillevalide.xml --noout
xmllint --schema validationgrille.xsd grilleinvalidelignecol.xml --noout
xmllint --schema validationgrille.xsd grilleivalidenombrecases.xml --noout
xmllint --schema validationgrille.xsd grilleinvalidecouleur.xml --noout

-- TESTS PARTIES (grilles valides) --
-- Ces fichiers génereront un fichier svg représentant la grille et indiquant par texte les erreurs ou gagants. --
xsltproc -o partienormale.svg transgrille.xslt partienormaleencours.xml
xsltproc -o partiegagnee.svg transgrille.xslt partiegagnee.xml
xsltproc -o partieanormale.svg transgrille.xslt partieanormaleencours.xml
xsltproc -o partietriche.svg transgrille.xslt partietriche.xml
xsltproc -o partieanormaletriche.svg transgrille.xslt partieanormaletriche.xml
xsltproc -o partieegalite.svg transgrille.xslt partieegalite.xml

-- GENERATION SVG -- 
si les svg générés par les commandes précédentes ne s'affichent pas correctement dans des navigateurs,
copiez-collez le code contenus dans le fichier svg à ce lien :
https://www.svgviewer.dev/

