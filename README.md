Project by : Xavier Refour @Xavier.Refour et Quentin Vandecandelaere @Quentin
***

App
====

Une méthode de classe *perform* de la classe **Scrapper** permet de lancer le menu pour choisir la méthode de récup de données.


Scrapper - Save as json
====

Construction en deux étapes :
- Première boucle pour transformer l'array de hash en un seul et même hash 'tempHash'
- Deuxième boucle pour écrire le résultat en json

Scrapper - Save as Spreadsheet
====

Construction :
- Initialisation et authentification
- Appel de la worksheet avec la clé
- Boucle sur l'array de hash (résultat du scrap) avec le nom de mairie en col1 et l'email en col2


Scrapper - Save as csv
====

Construction :
- Ouverture du csv en mode écriture
- Boucle sur l'array de hash : à chaque ligne du csv, chaque hash est renvoyée sous forme d'un array