
# Gestion des recettes 
Application Full-Stack (NodeJs + VueJs) de gestion des recettes de la semaine 



## Groupe 2
Membres du groupe :

- Kiady RAJOELISOLO (https://github.com/kiady696)
- Marouan KLAI (https://github.com/Marouankl)
- Anthony ROCHE




## Process de lancement du projet

Pour déployer ce projet :

- Cloner l'API : https://github.com/kiady696/marmittongr2
```bash
  git clone git@github.com:kiady696/marmittongr2.git 
```
- Installer la base de donnée marmittongr2.sql qui se trouve à la racine du projet API. (MySQL/MariaDb)
```bash
  mysql -u root -p marmittongr2 < marmittongr2.sql
```
- Cloner le projet de la partie Front End (VueJS) : https://github.com/Marouankl/front-office.
```bash
  git clone git@github.com:Marouankl/front-office.git
```

- Installer les dépendances js dans chaque projet (API et Front End).
```bash
  npm install
```

- Lancer le serveur npm de l'API
    - Se mettre dans le répertoire du projet API
```bash
  npm start app.js
```

- Lancer le serveur npm du Front End VueJS
    - Se mettre dans le répertoire du projet front end:
```bash
  npm run serve
```

- Lancer le projet dans votre navigateur favori avec l'adresse : 
```bash
  http://localhost:8080
```


## API References

Collection des routes sous ```Postman``` : https://martian-equinox-281491.postman.co/workspace/Team-Workspace~c2948b19-b6d8-483b-82c6-6a5b9162729d/collection/8911637-ff593a6c-f8ed-4752-b157-c67708100ece?action=share&creator=8911637

#### Liste de toutes les recettes avec leurs ingrédients

```http
  GET /api/recettes
```

#### Crée une nouvelle recette (sans ingrédients)

```http
  POST /api/recettes/create
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `nom_recette`      | `string` | **Required**. Le nom de la recette |
| `description_recette`      | `string` | **Required**. Description de la recette |
| `temps_preparation`      | `string` | **Required**. Temps de préparation de la recette |
| `temps_cuisson`      | `string` | **Required**. Le temps de cuisson de la recette |
| `difficulte`      | `string` | **Required**. La difficulté de la recette |
| `nb_personnes`      | `string` | **Required**. Le nombre de personnes prévu par la recette |

#### Génère la liste des courses pour la semaine

```http
  GET /api/marmiton/
```
Corps de la requête : 
```json
[
    {
        "no_jour": 0, // Le jour de la semaine (0:Lundi, 1:Mardi, etc...)
        "id_recette": 1, // Une des recettes qui est commandé ce jour là
        "nb_personnes_qui_va_le_manger": 2 // Le nombre de personnes qui va manger cette recette ce jour là
    },
    {
        "no_jour": 0, 
        "id_recette": 2,
        "nb_personnes_qui_va_le_manger": 3
    },
    {...},
    ...
]
```



## Pages et fonctionnalités

- Page de création d'une recette
- Page d'ajout d'un/de plusieurs ingrédient/s et/ou d'une étape pour une recette
- Commande de recette pour une semaine en spécifiant la date de commande
- Full-Stack en NodeJs et VueJS




## License

[GPLv3](https://www.gnu.org/licenses/gpl-3.0.html)

(Open Source Power ;) )
