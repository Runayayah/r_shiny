# Documentation sur le repository :


## Contenu : 

Le dossier data contient tout les données utiliser pour le projet.

- Dans ce dossier nous avons ; 

``` 
    - raw_data : fichier de base exporter de kaggle  
    - dim_data : fichier découpé pour crée la bdd
    - db_data : data base crée à partir de dim_data sur sqlite
``` 

Le dossier shiny_markdown est le code du markdown dédié à l'application.
-  il sert à crée une anayle de toute les données du projet.

``` 
``` 

Le dossier shiny_csv est le code de l'application shiny adapter avec les fichiers csv brut.

- Il sert à montrer de le code de [l'application publié](https://winterune.shinyapps.io/version_csv-r_shiny/), il contient ;

``` 
    - dim_gobal.csv : qui est le fichier qui contient la majorité des données traité. 
    - dim_sector.csv : fichier qui contient les différents secteurs des entreprise de la table dim_global.
    - dim_industry.csv : fichier qui contient les différents industry.
    - cosmo.min.css : fichier qui contient de style (theme) de l'application.
    - ui.R : fichier de l'interface graphique de l'application.
    - server.R : fichier du traitment des données de l'application.
```
Le dossier shiny_sql est le code de l'application shiny adapter avec un base de données sqlite.

- Il sert à montrer la version final du projet non publiable sur shinyapps car la base de données n'est stocker que en local il contient ;
```
    - bddb.db : fichier qui contient la base de données sqlite de l'application.    
    - cosmo.min.css : fichier qui contient de style (theme) de l'application.
    - ui.R : fichier de l'interface graphique de l'application.
    - server.R : fichier du traitment des données de l'application. 
```

