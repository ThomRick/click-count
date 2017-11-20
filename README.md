# Click Count application

[![Build Status](https://travis-ci.org/xebia-france/click-count.svg)](https://travis-ci.org/xebia-france/click-count)

## Processus

### Step 1 : Build

Le choix retenu pour le livrable de l'application est un conteneur Docker.
L'intérêt de ce choix est de fournir un livrable indépendant des librairies installées sur les machines hôtes de l'application tout en gardant un environnement de développement en adéquation avec le choix pris par les équipes de développement de l'application.

### Step2 : Infrastructure

#### Schéma de l'infrastructure

- - - - - - - - -   - - - - - - - - -
|               |   |               |
|    MASTER     |   |  PRODUCTION   |
|               |   |               |
- - - - - - - - -   - - - - - - - - -

#### Fonctionnement de l'infrastructure

  - Master : 
  Environnement contenant la version en cours de qualification de l'application.
  L'accès à cet environnement se fera dans un cadre interne à l'entreprise développant la solution.

  - Production :
  Environnement contenant la version en cours d'utilisation.