# Click Count application

[![Build Status](https://travis-ci.org/xebia-france/click-count.svg)](https://travis-ci.org/xebia-france/click-count)

## Processus

### Step 1 : Analyse de l'état actuel

   - Il s'agit d'une application java utilisant le gestionnaire de dépendances maven.
   - Le livrable resulant de la command ```maven clean install``` est un war.
   - Le fichier travis.yml m'indique que Travis peut me servir de support pour gérer le build de l'application.

### Step 2 : Adaptation du livrable de l'application - Approche container
 
   - Je construis une image docker s'appuyant sur l'image tomcat en guise de server d'applications pour le livrable final.
   - Il en résulte que je dois adapter le fichier travis.yml afin de build l'image docker.

### Step 3 : Mise en oeuvre du processus de build
 
 Le build de l'application via Travis va donc se faire suivant les étapes:
 
   - ```maven clean install``` (pour obtenir le war)
   - ```docker build .```      (pour obtenir l'image docker contenant le server d'application avec l'application)
   
 Afin d'être plus flexible dans le processus de build nous allons utiliser un conteneur docker pour les 2 étapes du build.
 Le but étant d'être indépendant de la version de java installée sur la machine de build