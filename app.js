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

// Liste toutes les recettes avec leurs ingrédients
app.get('/api/recettes/', (req, res) =>{
    // creation nouveau tableau 
    var recettesSimples = [];
    var recettesEnrichies = [];
    // receuil de toutes les recettes
    con.query('SELECT * FROM recettes', (err, sql_results1) =>{
        if(err) throw err;
        recettesSimples = sql_results1; // les recettes 'simples' (sans ingrédients)
        // pour chaque recette, récupérer ses ingrédients
        recettesSimples.forEach(recette => {
            con.query('SELECT * FROM ingredients LEFT JOIN recettes_ingredients ON recettes_ingredients.id_ingredient = ingredients.id_ingredient WHERE recettes_ingredients.id_recette = ?', 
            [recette.id_recette], 
            (err, sql_result2) =>{
                if(err) throw err;  
                recette['ingredients'] = sql_result2; // ajoute les ingrédient en tant qu'attribut de la recette
                recettesEnrichies.push(recette); // ajoute au nouveau tableau de 'recettes enrichies'
                if(recettesEnrichies.length == recettesSimples.length) res.json(recettesEnrichies); // les recettes avec leurs ingrédients
            });
        });
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