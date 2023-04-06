# API Application Liste des courses RTAI 2023
# 1 - Membres du Groupe 2 
  - Kiady RAJOELISOLO
  - Marouan KLAI
  - Anthony ROCHE
# 2 - Installation du projet
  Dans un terminal :
  - ```git clone git@github.com:kiady696/marmittongr2.git``` en se mettant là où vous voulez installer le projet 
  - ```npm install``` dans le répertoire source du projet cloné (En ayant une version de nodejs >= 18.15.0 installé sur votre machine)
  - Importer la base de donnée 'marmittongr2.sql' (dump présent dans ce repository si je n'oublie pas de le mettre :p) dans votre environnement de test (serveur de test de base de donnée) MySQL (XAMPP, LAMP, UWAMP, etc...)
  - Faire marcher la base de donnée sur le port 3306 de votre serveur de base de donnée (configuration par défaut de l'application), vous pouvez aussi paramétrer votre app.js en fonction de vos préférences
  - Faire les modifications nécessaires au code ```const mysql = require('mysql');
const con = mysql.createConnection({
  host:'localhost',
  port:3306,
  user:'root',
  password : '', 
  database : 'marmittongr2'
});```
  - ```node app.js``` et voilà, votre API est prête à écouter et recevoir les requêtes du front end VueJS ;)
