// const http = require('http');
// const hostname = '127.0.0.1';
'use strict';
const express = require('express');
const app = express();
const hostname = 'localhost';
const port = 3000;

app.listen(port, hostname, () => {
    console.log(`app running at http://${hostname}:${port}/`);
  });
  
app.use(express.json());
app.use(express.urlencoded({extended: true}));

const mysql = require('mysql');
const con = mysql.createConnection({
  host:'localhost',
  port:3306,
  user:'root',
  password : '',  
  database : 'marmittongr2'
});

// importation des fonctions utilitaires
var utils = require('./utils');

/**
 * Génére et calcule les quantités nécessaires d'ingrédients à acheter 
 * En fonction des recettes et du nombre de personnes qui mangeront pour un jour
 * Et ce pendant une semaine
 *  ||||||||| Endpoint principal de l'application |||||||||||
 **/ 
app.post('/api/marmiton/', (req, res) =>{

    var jsonObject = req.body;
    var uneCommande = {};
    var tabCommandes = [];
    // res.json(jsonObject);
    /**
     * Ce qu'il y aura dans le req.body :
     * UN TABLEAU DE : 
     * [ La recette (id_recette ou même un objet entier),  
     * Le n° du jour de la semaine (0 -> 6), 
     * Le nombre de personnes qui vont manger la recette ]
     **/ 
    jsonObject.forEach(commandeJour => {

        // recueil des ingrédients, leur quantité, unité et prix
        con.query('SELECT i.nom_ingredient, ri.quantite, i.prix, i.unite FROM ingredients as i JOIN recettes_ingredients AS ri ON ri.id_ingredient=i.id_ingredient WHERE ri.id_recette=?', [commandeJour.id_recette], (err, sql_results1) =>{
            if(err) throw err;
            uneCommande = sql_results1;
            uneCommande['nbPersonnes'] = commandeJour.nb_personnes_qui_va_le_manger;
            // push dans le tableau des commandes
            tabCommandes.push(uneCommande); 
            if (tabCommandes.length === jsonObject.length) res.json(tabCommandes); // se rempli que quand la requete 

            
        });
    });

    // Parcourir sur chaque tableau d'ingrédients
    //tabCommandes.forEach( ingredients =>{

    });




    // la taille du tableau ne pourra pas excéder 7 (pour les 7 jours de la semaine)
    // On va calculer : Si recettes_ingredients.quantité pour la recette est de 100g 
    // Et que la recette est faite pour 1 personne, 
    // Alors il faudrait 200g de cet ingrédient si deux personnes veut manger ce jour là.
    // => qte_finale_necessaire_d_un_ingredient = 
    // (nb_personnes_qui_vont_manger * recettes_ingredients.quantite) / nb_personnes_prevu_par_la_recette

});


// Liste toutes les recettes avec leurs ingrédients
app.get('/api/recettes/', (req, res) =>{
    // creation nouveau tableau 
    var recettesSimples = [];
    var recettesEnrichies = [];
    
    // receuil de toutes les recettes
    new Promise((resolve, reject) => {
        con.query('SELECT * FROM recettes', (err, sql_results1) =>{
            if(err) reject(err);
            recettesSimples = sql_results1; // les recettes 'simples' (sans ingrédients)
            resolve();
        }); 
    }).then(() => {
        // pour chaque recette, récupérer ses ingrédients
        var promises = recettesSimples.map((recette) => {
            return new Promise((resolve, reject) => {
                con.query('SELECT * FROM ingredients LEFT JOIN recettes_ingredients ON recettes_ingredients.id_ingredient = ingredients.id_ingredient WHERE recettes_ingredients.id_recette = ?', [recette.id_recette], (err, sql_result2) => {
                    if(err) reject(err);  
                    recette['ingredients'] = sql_result2; // ajoute les ingrédient en tant qu'attribut de la recette
                    recettesEnrichies.push(recette); // ajoute au nouveau tableau de 'recettes enrichies'
                    resolve();
                });
            });
        });

        // pour chaque recette, récupérer l'étape
        var promises = recettesSimples.map((recette) => {
            return new Promise((resolve, reject) => {
                con.query('SELECT * FROM etapes WHERE etapes.id_recette = ?', [recette.id_recette], (err, sql_result3) => {
                    if(err) reject(err);  
                    recette['etapes'] = sql_result3; // ajoute les ingrédient en tant qu'attribut de la recette
                    recettesEnrichies.push(recette); // ajoute au nouveau tableau de 'recettes enrichies'
                    resolve();
                });
            });
        });

        Promise.all(promises).then(() => {
            res.json(recettesEnrichies);
        }).catch((err) => {
            throw err;
        });
    }).catch((err) => {
        throw err;
    });
});

// Crée un ingrédient et l'ajoute à une recette en même temps 
app.post('/api/recettes/:id_recette/ingredients/add', (req, res) =>{
    // Création de l'ingrédient
    const ingredient = {
        nom_ingredient : req.body.nom_ingredient, 
        description_ingredient : req.body.description_ingredient,
        unite: req.body.unite,
        prix: req.body.prix,
    }
    // Creation de l'ingrédient
    con.query('INSERT INTO ingredients (nom_ingredient, description_ingredient, unite, prix) VALUES (?, ?, ?, ?)',
        [ingredient.nom_ingredient, ingredient.description_ingredient, ingredient.unite, parseFloat(ingredient.prix)],
        (err, sql_result1) =>{
            if(err) throw err
            // Lie l'ingrédient à la recette 
            con.query('INSERT INTO recettes_ingredients (id_recette, id_ingredient, quantite) VALUES (?,?,?)', 
            [req.params.id_recette, sql_result1.insertId, req.body.quantite], 
            (err, sql_result2) =>{
                if(err) throw err;
                res.json({
                    message: 'L\'ingrédient fraîchement créé d\'id '+sql_result1.insertId+' a bien été créé et associé à la recette d\'id '+req.params.id_recette,
                    recette: ingredient, 
                });
            })
    })
});

// Crée une recette 
app.post('/api/recettes/create', (req, res) =>{
    // Creation de la nouvelle recette à ajouter
    const recette = {
        nom_recette: req.body.nom_recette,
        description_recette: req.body.description_recette,
        temps_preparation: req.body.temps_preparation,
        temps_cuisson: req.body.temps_cuisson,
        difficulte: req.body.difficulte,
        nb_personnes: req.body.nb_personnes,
    };

    // Insertion dans la base de donnée 
    con.query('INSERT INTO recettes (nom_recette, description_recette, temps_preparation, temps_cuisson, difficulte, nb_personnes) VALUES (?, ?, ?, ?, ?, ?)', 
        [recette.nom_recette, recette.description_recette, parseInt(recette.temps_preparation), parseInt(recette.temps_cuisson), recette.difficulte, parseInt(recette.nb_personnes)], (err, sql_result) => {
            if(err) throw err;
            res.json({
                message: 'La recette a bien été ajoutée',
                recette: recette, 
            });

        });
});

// Modifie une recette existante 
app.put('/api/recettes/update/:id', (req, res) =>{
    // Creation de la nouvelle recette à modifier
    const recette = {
        nom_recette: req.body.nom_recette,
        description_recette: req.body.description_recette,
        temps_preparation: req.body.temps_preparation,
        temps_cuisson: req.body.temps_cuisson,
        difficulte: req.body.difficulte,
        nb_personnes: req.body.nb_personnes,
    };

    // Mise à jour de la recette dans la bdd
    con.query('UPDATE recettes SET nom_recette = ?, description_recette = ?, temps_preparation = ?, temps_cuisson = ?, difficulte = ?, nb_personnes = ? WHERE id_recette = ?', 
        [recette.nom_recette, recette.description_recette, parseInt(recette.temps_preparation), parseInt(recette.temps_cuisson), recette.difficulte, parseInt(recette.nb_personnes), req.params.id], 
        (err, sql_result) =>{
            if(err) throw err;
            res.json({
                message: 'La recette a bien été modifiée',
                recette: recette, 
            });

        });
})