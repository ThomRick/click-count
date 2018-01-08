# Click Count application

[![Build Status](https://travis-ci.org/ThomRick/click-count.svg)](https://travis-ci.org/ThomRick/click-count)

## Processus

### Step 1 : Build

Le choix retenu pour le livrable de l'application est un container Docker.
L'intérêt de ce choix est de fournir un livrable indépendant des librairies installées sur les machines hôtes de l'application tout en gardant un environnement de développement en adéquation avec le choix pris par les équipes de développement de l'application.

### Step2 : Infrastructure

Le choix technologique pour l'infrastructure est de déployer le container Docker de l'application dans un cluster Kubernetes déployé par le biais du provider cloud Google Cloud Platform.
L'infrastructure as code s'appuie sur la technologie terraform.

#### Deploiement continu

* Les ressources :
    * Une zone DNS
    * Un DNS record A pour lié l'addresse IP du load balancer de l'application à un sous domaine rattaché à la zone DNS.
    * Un DNS record CNAME pour exposer l'application sur internet par le biais du sous domaine.
    * Un cluster Kubernetes
    * Par branch :
        * Un Pod exécutant un container Redis avec son service NodePort associé.
        * Un Pod exécutant le container de l'application click-count et son service LoadBalancer associé. 

* Hooks :
    * A chaque commit de code sur le repository GitHub de l'application, un job de build est déclenché sur Travis CI.
    * A l'issue de se job un autre job de déploiement est déclenché afin de mettre à jour l'infrastructure sur l'environnement de staging.

#### Remarques :

* Le déploiement sur l'environnement de production se produit par l'action d'un utilisateur.
* Pour se faire l'utilisateur doit construire le container Docker infra et l'exécuter avec les arguments ``` production ${VERSION} ```

### Difficultés rencontrées :

#### Technologie Terraform :

* Pour mettre à jour l'infrastructure sur un environnement la méthode de récupération de l'état courant est d'importer les ressources.
L'ensemble des ressources de peuvent pas être importés à l'aide des dernières versions actuelles des providers utilisés.
Il a donc été nécessaire de construire les providers contenant les versions (en cours de développement) de ces providers.

* La technologie terraform ne permet pas d'utiliser les fonctionnalités beta des ressources Kubernetes (cf. Deployement). 