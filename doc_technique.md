# **Documentation technique**. 

Cette documentation contiendras les élèments suivant : 
- Les librairies utilisées pour les différents fichier.
- Une description du fonctionnement de l'application.
- Un présentation du MCD.
- Les différents bug possible. 

## **Librairies utiliser pour le projet** : 

Le projet utilise de nombreuse libraies notamment.

*Pour le dossier shiny_csv* : 
``` 
-shiny
-ggplot2
-treemapify
-readr
```
*Pour le dossier shiny_sql* : 
``` 
-shiny
-ggplot2
-treemapify
-RSQLite
```
*Pour le dossier markdown* :
``` bash
-markdown
-ggplot2
```
## **Fonctionnement de l'application shiny**

#### ***Différence entre les versions et origine des données***

Il n'y pas de différences entre les fichiers sql_shiny et csv_shiny seule leur source de données différe. L'un prend ses sources dans trois fichiers csv et l'autre prend sa source dans une base de données crée sur sqlite. les deux sources de données prennent leur origine dans une seule base de données extraite du site kaggle. 

### ***Description global du code de l'application***

L'application est donc séparer en deux script R : 
- server.R : script R qui défini tout les calculs et les fonctions qui gére tout les graphique et fonctionnalité de l'application tel que : 
    - Les onglets 
    - Le bouton de téléchargement 
    - le calcule et l'aggrégation des graphique 
- ui.R : script R qui défini toute l'interface graphique du projet tel que :
    - le theme 
    - le placement des graphiques et le tableau de données

## **Présentation du MCD**


